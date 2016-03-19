module ApplicationHelper

  # DateTime の Range オブジェクトを文字列に変換する
  # TODO begin と end の日付が違う場合に対応する
  def tsrange2str(range)
    return { date: '', begin: '', end: '' } if range.blank?
    date = range.begin.strftime('%Y/%m/%d')
    week = %w(日 月 火 水 木 金 土)[range.begin.wday]
    return {
      date:  "#{date}(#{week})",
      begin: range.begin.strftime('%H:%M'),
      end:   range.end.strftime('%H:%M'),
    }
  end

end
