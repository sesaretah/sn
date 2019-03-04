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

end
