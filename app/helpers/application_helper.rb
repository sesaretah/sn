module ApplicationHelper
  def color
    @colors = ['#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', '#008080', '#e6beff', '#9a6324', '#fffac8', '#800000', '#aaffc3', '#808000', '#ffd8b1', '#000075', '#808080', '#ffffff', '#000000']
    return @colors[rand(0..19)]
  end

  def colors(i)
    @colors = ['#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', '#008080', '#e6beff', '#9a6324', '#fffac8', '#800000', '#aaffc3', '#808000', '#ffd8b1', '#000075', '#808080', '#ffffff', '#000000']
    return @colors[i]
  end

  def sexes
    @options = [
      [t(:male), t(:male)],
      [t(:female) , t(:female)]
    ]
    return @options
  end

  def to_jalali(date)
    @j = JalaliDate.to_jalali(date)
    return "#{@j.year}/#{@j.month}/#{@j.day}"
  end


  def grant_access(ward, user)
    @flag = 0
    if user.assignments.blank?
      return false
    end
    if user.current_role_id.blank?
      return false
    else
      @ac = AccessControl.where(role_id: user.current_role_id).first
      if !@ac.blank?
        @flag = @ac["#{ward}"] && 1 || 0
      end
    end

    if @flag == 1 || is_admin(user)
      return true
    else
      return false
    end
  end

  def is_admin(user)
    @flag = false
    if !user.assignments.blank? && !user.current_role_id.blank?
      @ac_role = AccessControl.where(role_id: user.current_role_id).first
      if !@ac_role.blank? && @ac_role.ability_to_administrate
        @flag = true
      end
    end
    if @flag
      return true
    else
      return false
    end
  end

  def check_owner(obj)
    if obj.user_id == current_user.id || is_admin(current_user)
      return true
    else
      return false
    end
  end

end
