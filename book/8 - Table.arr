use context essentials2021
include gdrive-sheets
include data-source
include tables



ssid = "1DKngiBfI2cGTVEazFEyXf7H4mhl8IU5yv2TfZWv6Rc8"


event-data =
  load-table: name, email, tickcount, discount, delivery
    source: load-spreadsheet(ssid).sheet-by-name("Data", true)
    sanitize name using string-sanitizer
    sanitize email using string-sanitizer
    sanitize tickcount using num-sanitizer
    sanitize discount using string-sanitizer
    sanitize delivery using string-sanitizer
  end
count(discount-fixed, "discount")


#|
fun cell-to-discount-code(e-list :: List<String>) -> List<String>:
  doc: ```uppercase all strings other than none,
       convert blank cells to contain none```
  if (str == "") or (string-to-lower(str) == "none"):
    "none"
  else:
    string-to-upper(str)
  end
where:
  cell-to-discount-code("") is "none"
  cell-to-discount-code("none") is "none"
  cell-to-discount-code("NoNe") is "none"
  cell-to-discount-code("birthday") is "BIRTHDAY"
  cell-to-discount-code("Birthday") is "BIRTHDAY"
end

fun order-scale-label(r :: Row) -> String:
  doc: "categorize the number of tickets as small, medium, large"
  numtickets = r["tickcount"]

  if numtickets >= 10: "large"
  else if numtickets >= 5: "medium"
  else: "small"
  end
end


cleaned-event-data =
  transform-column(
    transform-column(event-data, "discount", cell-to-discount-code))

order-bin-data =
  build-column(cleaned-event-data, "order-scale", order-scale-label)
   
|#