import
    std/[httpclient, strutils, random, strformat, times, math]

var alphanum = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

proc GenerateCode: string =
    randomize()
    for i in 0 .. 23:
        result.add(alphanum[rand(alphanum.high)])

proc CheckCode(code: string): bool =
    var client = newHttpClient()
    let response = client.get(&"https://discordapp.com/api/v9/entitlements/gift-codes/{code}?with_application=false&with_subscription_plan=true")
    return (response.code == Http200)

when isMainModule:
    var begintime = cpuTime()
    discard CheckCode(GenerateCode())
    var endtime = cpuTime()
    echo &"Time taken: {$(endTime - beginTime)} seconds"
    var numbersofcodes = pow((26.0 + 26.0 + 10.0),  23.0)
    var totalcodes = (endtime - begintime) * numbersofcodes
    var timeinyear = totalcodes / 60.0 / 60.0 / 24.0 / 365.0 / 1000.0
    echo &"it would take {$timeinyear} millenials to generate {$numbersofcodes} codes"