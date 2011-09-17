require 'capybara/util/save_and_open_page'

if Rails.version.to_f >= 3.1 and Rails.application.config.assets.enabled
  module Capybara
    class << self
      def save_page(html, file_name=nil)
        rewrite_css_assets
        save_page_html(html, file_name)
      end

      protected

      def save_page_html(html, file_name=nil)
        file_name ||= "capybara-#{Time.new.strftime("%Y%m%d%H%M%S")}#{rand(10**10)}.html"
        name = File.join(*[Capybara.save_and_open_page_path, file_name].compact)

        unless Capybara.save_and_open_page_path.nil? || File.directory?(Capybara.save_and_open_page_path )
          FileUtils.mkdir_p(Capybara.save_and_open_page_path)
        end
        FileUtils.touch(name) unless File.exist?(name)

        tempfile = File.new(name,'w')
        tempfile.write(rewrite_css_and_image_references(rewrite_asset_references(html)))
        tempfile.close
        tempfile.path
      end

      def rewrite_css_assets
        asset_prefix = Rails.application.config.assets.prefix
        public_asset_path = Rails.public_path + asset_prefix
        raise "You need to run rake assets:precompile first!" unless Dir.exists?(public_asset_path)
        Dir.glob(File.join(public_asset_path, "*.css")).each do |asset|
          file_name = "capybara-#{File.basename(asset)}"
          name = File.join(*[Capybara.save_and_open_page_path, file_name].compact)
          unless File.exists?(name)
            css = IO.read asset
            css = rewrite_css_and_image_references(rewrite_asset_references(css))
            tempfile = File.new(name, "w")
            tempfile.write(css)
            tempfile.close
          end
        end
      end
      
      def rewrite_asset_references(source)
        asset_prefix = Rails.application.config.assets.prefix
        public_asset_path = Rails.public_path + asset_prefix
        Dir.glob(File.join(public_asset_path, '**/*.*')).each do |asset|
          dirname = File.dirname(asset)
          basename = File.basename(asset)
          clean_name = asset.match(/.+\/(?<name>.+)-[\d\w]{32}(?<ext>.+)$/) {|md| md[:name] + md[:ext]}
          path_root = dirname.sub(public_asset_path, '') + '/'
          if asset.include?('.css')
            if !basename.start_with?('capybara-')
              asset = File.join(Capybara.save_and_open_page_path, "capybara-#{basename}")
            else
              next
            end
          end
          source.gsub!(/\/assets#{path_root}(#{clean_name}|#{basename})/, asset)
        end
        return source
      end

      def rewrite_css_and_image_references(source)
        root = Capybara.asset_root
        asset_prefix = Rails.application.config.assets.prefix
        directories = Dir.new(root).entries.select { |name|
          (root+name).directory? and not name.to_s =~ /^\./ and not name.to_s == asset_prefix.delete('/')
        }
        if not directories.empty?
          source.gsub!(/("|')\/(#{directories.join('|')})/, '\1' + root.to_s + '/\2')
        end
        return source
      end
    end
  end
end