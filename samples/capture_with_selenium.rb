require 'selenium-webdriver'

width = 1024
height = 728

d = Selenium::WebDriver.for :firefox
d.navigate.to 'http://blog.marsbar.us'
d.execute_script %Q{window.resizeTo(#{width}, #{height});}
d.save_screenshot('screenshot.png')
d.quit
