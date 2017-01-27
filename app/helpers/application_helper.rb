module ApplicationHelper

  # I'm lovin' it
  def link_to_if_else_span(predicate, options)
    url = options.delete(:href)
    if predicate
      link_to url, options do
        yield if block_given?
      end
    else
      content_tag(:span, class: options[:class]) do
        content_tag(:strong) do
          yield if block_given?
        end
      end
    end
  end

  # God help me
  def preschool_closes_class(preschool)
    return 'default' unless preschool.is_open
    diff = (preschool.closes - Time.current).to_f/3600
    case diff
    when (2.0)..(12.0)
      'success'
    when (1.0)..(2.0)
      'info'
    when (0.5)..(1.0)
      'warning'
    when (0.0)..(0.5)
      'danger'
    end
  end

  def preschool_closes_class_debug(preschool)
    #return ['warning', 'info', 'danger', 'success'].sample
    debug_time_now = Time.new(2017,01,27,13,45,00)
    last = preschool.hours.today.last.closes
    debug_time = Time.new(2017,01,27,last.hour,last.min,00)
    diff = (debug_time - debug_time_now).to_f/3600
    case diff
    when (2.0)..(12.0)
      'success'
    when (1.0)..(2.0)
      'info'
    when (0.5)..(1.0)
      'warning'
    when (0.0)..(0.5)
      'danger'
    end
  end

end
