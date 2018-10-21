defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekday_names_map [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
                     |> Enum.with_index(1)
                     |> Enum.into(%{})

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    {:ok, first_date_in_month} = Date.new(year, month, 1)
    {day_of_month, weekday_date} = weekday_date(first_date_in_month, weekday)

    case schedule do
      :first ->
        weekday_date

      :second ->
        Date.add(weekday_date, 7)

      :third ->
        Date.add(weekday_date, 14)

      :fourth ->
        Date.add(weekday_date, 21)

      :last ->
        last_day = day_of_month + 28

        last_day =
          if last_day > Date.days_in_month(weekday_date) do
            last_day - 7
          else
            last_day
          end

        Date.add(weekday_date, last_day - day_of_month)

      :teenth ->
        Date.add(weekday_date, teenth(day_of_month + 7) - day_of_month)
    end
    |> Date.to_erl()
  end

  defp teenth(day) when day > 12, do: day
  defp teenth(day), do: teenth(day + 7)

  defp weekday_date(%Date{} = start_of_month_date, weekday_name) do
    weekday = @weekday_names_map[weekday_name]

    case Date.day_of_week(start_of_month_date) do
      ^weekday ->
        {1, start_of_month_date}

      first_weekday when first_weekday > weekday ->
        days = 7 - first_weekday + weekday
        {days + 1, Date.add(start_of_month_date, days)}

      first_weekday ->
        days = weekday - first_weekday
        {days + 1, Date.add(start_of_month_date, days)}
    end
  end
end
