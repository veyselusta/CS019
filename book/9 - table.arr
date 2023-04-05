use context essentials2021
include gdrive-sheets
include data-source

import math as M
import statistics as S

import lists as L

ssid = "1DKngiBfI2cGTVEazFEyXf7H4mhl8IU5yv2TfZWv6Rc8"
cleaned-data =
  load-table: name, email, tickcount, discount, delivery
    source: load-spreadsheet(ssid).sheet-by-name("Cleaned", true)
    sanitize name using string-sanitizer
    sanitize email using string-sanitizer
    sanitize tickcount using num-sanitizer
    sanitize discount using string-sanitizer
    sanitize delivery using string-sanitizer
  end

tickcounts = cleaned-data.get-column("tickcount")
discounts = cleaned-data.get-column("discount")

M.max(tickcounts)

L.distinct(discounts)
L.remove(L.distinct(discounts), "none")

fun removelow(word :: String) -> Boolean:
  not(word == string-to-lower(word))
where:
  removelow("sS") is true
  removelow("ss") is false
end

str-list = [list: "ssss", "Vesss", "VVVVV", "00sddd", "00DDDD"]
L.filter(removelow, str-list)

fun web-com-address(email :: String) -> Boolean:
  doc: "Checks and determines if the mail adresses come from web.com"
  string-split(email, "@").get(1) == "web.com"
where:
  web-com-address("bonnie@pyret.org") is false
  web-com-address("bonnie@web.com") is true
end
  
emails = cleaned-data.get-column("email")
L.length(L.filter(web-com-address, emails))

fun extract-username(email :: String) -> String:
  doc: "extract the portion of an email address before the @ sign"
  string-split(email, "@").get(0)
where:
  extract-username("bonnie@pyret.org") is "bonnie"
  extract-username("parrot@web.com") is "parrot"
end

L.map(extract-username,
  [list: "parrot@web.com", "bonnie@pyret.org"])

## Exercise - recipes-uses

stir-fry = [list: "peppers", "pork", "onions", "rice"]
dosa = [list: "rice", "lentils", "potato"]
misir-wot = [list: "lentils", "berbere", "tomato"]

fun recipes-uses(recipe :: List<String>, ingredient :: String) -> Boolean:
  doc: "Determines whether the recipe uses the ingredient"
  recipe.member(ingredient)
where:
  recipes-uses([list: "apple", "orange", "banana"], "banana") is true
end

## Exercise - make-vegetarian

fun make-vegetarian(recipe :: List<String>) -> List<String>:
  doc: "Replaces all meat ingredients with tofu"
  fun helper(str :: String) -> String:
    if (str == "pork") or (str == "chicken") or (str == "beef"):
      "tofu"
    else:
      str
    end    
  end
  recipe.map(helper)
  where:
  make-vegetarian([list: "tofu", "pork", "beef", "salad", "orange"])
      is [list: "tofu", "tofu", "tofu", "salad", "orange"]
end

## Exercise - protein-veg-count

fun protein-veg-count(recipe :: List<String>) -> Number:
  doc: "Determines how many ingredients are in the list that aren't rice or noodles"
  fun helper(ingredient :: String) -> Boolean:
    (ingredient == "rice") or (ingredient == "noodles")
  end
  (recipe.length()) - (recipe.filter(helper).length())
where:
  protein-veg-count([list: "rice", "noodles", "orange", "apple", "banan"]) is 3
end

## Exercise - More challenging

## Exercise- Another more challenging

## Exercise - Extract the list of usernames from a list of email addresses using lam rather than a named helper-function

emails.map(lam(email): string-split(email, "@").get(0) end)

## Exercise - Consider a question such as "how many people with ".org" email addresses bought more than 8 tickets". Which different collections of table and list functions could you use to write this program?
