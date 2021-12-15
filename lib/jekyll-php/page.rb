module Jekyll
  class Page
    include Php::Constants

    def template
      if !html? && !php?
        "/:path/:basename:output_ext"
      elsif index?
        "/:path/"
      else
        Utils.add_permalink_suffix("/:path/:basename", site.permalink_style)
      end
    end

    def php?
      return PHP_EXTENSIONS.include?(output_ext)
    end
  end
end