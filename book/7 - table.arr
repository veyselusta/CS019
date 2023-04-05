use context essentials2021
include tables

people :: Table = table: name, age
  row: "Alice", 30
  row: "Bob", 40
  row: "Carol", 25
end

shuttle = table: month, riders
  row: "Jan", 1123
  row: "Feb", 1045
  row: "Mar", 1087
  row: "Apr", 999
end

fun cleared-1K(r :: Row) -> Boolean:
  doc: "Determine whether given row has at least 1000 riders"
  r["riders"] > 1000
where:
  cleared-1K(shuttle.row-n(1)) is true
  cleared-1K(shuttle.row-n(41)) is true
end

fun cleared-1Kv2(row-pos :: Number) -> Boolean:
  doc: "Determine whether given row has at least 1000 riders"
  shuttle.row-n(row-pos)["riders"] > 1000
where:
  cleared-1Kv2(2) is true
  cleared-1Kv2(5) is true
end

months = table: months
  row: "Jan"
end


fun is-winter(r :: Row) -> Boolean:
  month = r["months"]
  (month == "Jan") or (month == "Feb") or (month == "Mar")
where:
  is-winter(months.row-n(0)) is true
end


low-winters = table: month, riders
  row: "Jan", 855
  row: "Feb", 800
  row: "March", 900
  row: "April", 852
  row: "May", 851
  row: "June", 855
  row: "Jully", 855
  row: "September", 855


    
end


fun low-winter(r :: Row) -> Boolean:
  month = r["month"]
  riders = r["riders"]
  
  if ((month == "Jan") or (month == "March") or (month == "Feb")) and (riders < 850):
    true
  else:
    false
  end
  
where:
  low-winter(low-winters.row-n(1)) is true
end


fun below-1K(r :: Row) -> Boolean:
  doc: "determine whether row has fewer than 1000 riders"
  r["riders"] < 1000
where:
  below-1K(shuttle.row-n(2)) is false
  below-1K(shuttle.row-n(3)) is true
end

filter-with(shuttle, below-1K)

employees =
  table: name, hourly-wage, hours-worked, total-wage
    row: "Harley", 15, 40, 15 * 40
    row: "Obi", 20, 45, 20 * 45
    row: "Anjali", 18, 39, 18 * 39
    row: "Miyako", 18, 40, 18 * 40
  end

fun compute-wages(wage :: Number, hours :: Number) -> Number:
  wage * hours
end

employeesv2 =
  table: name, hourly-wage, hours-worked, total-wage
    row: "Harley", 15, 40, compute-wages(15, 40)
    row: "Obi", 20, 45, compute-wages(20, 45)
    row: "Anjali", 18, 39, compute-wages(18, 39)
    row: "Miyako", 18, 40, compute-wages(18, 40)
  end


fun compute-wagesv2(r :: Row) -> Number:
  r["hourly-wage"] * r["hours-worked"]
end

#build-column(employeesv2, "total-wage", "compute-wagesv2")

