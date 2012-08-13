module RoutingFilter
  class Department < Filter
    @@include_default_department = true
    cattr_writer :include_default_department

    class << self
      def include_default_department?
        @@include_default_department
      end

      def departments
        @@departments ||= ::Department.pluck("name").map(&:to_sym)
      end

      def departments=(departments)
        @@departments = departments.map(&:to_sym)
      end

      def departments_pattern
        @@departments_pattern ||= %r(^/(#{self.departments.map { |d| Regexp.escape(d.to_s) }.join('|')})(?=/|$))i
      end
    end


    attr_reader :exclude
    def initialize(*args)
      super
      @exclude = options[:exclude]
    end


    def around_recognize(path, env, &block)
      department = extract_segment!(self.class.departments_pattern, path) # remove the department from the beginning of the path
      yield.tap do |params|                                       # invoke the given block (calls more filters and finally routing)
        params[:department] = department if department                        # set recognized department to the resulting params hash
      end
    end

    def around_generate(*args, &block)
      params = args.extract_options!                              # this is because we might get a call like forum_topics_path(forum, topic, :department => :en)
      department = params.delete(:department)                             # extract the passed :department option
      department = ::Department.current_department if department.nil? # default to current_department when department is nil (could also be false)
      department = "management" unless valid_department?(department)#reset to management as default department

      args << params

      yield.tap do |result|        
        url = result.is_a?(Array) ? result.first : result
        prepend_segment!(result, department) if prepend_department?(department) && !excluded?(url)
      end
    end

    protected
    def valid_department?(department)
      department && self.class.departments.include?(department.to_sym)
    end

    def default_department?(department)
      department && department.to_sym == "management".to_sym
    end

    def prepend_department?(department)
      department && (self.class.include_default_department? || !default_department?(department))
    end
    
    def excluded?(url)
      case exclude
      when Regexp
        url =~ exclude
      when Proc
        exclude.call(url)
      end
    end
  end
end
