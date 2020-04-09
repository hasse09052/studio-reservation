module ReservationsHelper

  # 渡された日時が今日から何週後かを返す 今週なら0を返し、来週なら1を返す
  def todayDiffWeek(time)
    return ((time.beginning_of_day - Time.current.beginning_of_day) / 60 / 60 / 24 / 7).to_i
  end
end
