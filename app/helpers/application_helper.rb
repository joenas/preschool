module ApplicationHelper

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
end
