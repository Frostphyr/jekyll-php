module Jekyll
  class Document
    include Php::Constants

    def destination(base_directory)
      @destination ||= {}
      @destination[base_directory] ||= begin
        path = site.in_dest_dir(base_directory, URL.unescape_path(url))
        if url.end_with? "/"
          path = File.join(path, "index")
          path.concat(PHP_EXTENSIONS.include?(output_ext) ? output_ext : ".html")
        else
          path << output_ext unless path.end_with? output_ext
        end
        path
      end
    end
  end
end