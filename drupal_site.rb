require "open-uri"
require "ruby-progressbar"
require "net/http"
require "uri"

def setup_drupal(sitename)
	currentDirectory = Dir.pwd

	download("http://ftp.drupal.org/files/projects/drupal-7.33.zip", currentDirectory, sitename)
end


def setup_theme()

end


def setup_modules()

end

def download(url, path, filename)
	url_base = url.split('/')[2]
	url_path = '/'+url.split('/')[3..-1].join('/')
	url_ext = url[-3..-1]
	
	puts url_base

	Net::HTTP.start(url_base) do |http|
	    response = http.request_head(URI.escape(url_path))
	    total_size = response["content-length"].to_i

	    pbar = ProgressBar.create(:title => "Progress", :total => total_size, :format => '%a <%B> %p%% %t')
	    File.open("#{path}/#{filename}.#{url_ext}", 'wb') do |f|
	        http.get(URI.escape(url_path)) do |bytes|
	            f.write bytes
	            # pbar.log "Site Address -> #{url}"
	            pbar.progress += bytes.length
	        end
	    end
	end
end

def main()
	if ARGV[0]
		sitename = ARGV[0]
		setup_drupal(sitename)
		setup_theme(sitename)
		setup_modules()
	else
		puts "USUAGE"
	end
end

if __FILE__ == $0
	main()
end