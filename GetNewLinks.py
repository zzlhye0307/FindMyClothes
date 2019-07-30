#! /usr/bin/python
# -*- coding: utf-8 -*-
import time
import datetime
from selenium import webdriver

def getNewGoodsLinks(shopName): 
    path = "/Users/cs402a/Desktop/chromedriver"
    driver = webdriver.Chrome(path)
    
    fName = shopName + "상품정보"
    fDirectory = "/Users/cs402a/Desktop/PythonFile/" + shopName + "/" + fName
    
    
    if shopName == "육육걸즈":
        url = "https://66girls.co.kr/product/list.html?cate_no=76"
        driver.get(url)
        for i in range(1, 100):
            try:
                a = driver.find_element_by_xpath("/html/body/div[4]/div[2]/div[2]/div[2]/div[4]/ul/li[" + str(i) + "]/div/div[1]/div/a")
                link = a.get_attribute("href")
                img =driver.find_element_by_xpath("/html/body/div[4]/div[2]/div[2]/div[2]/div[4]/ul/li[" + str(i) + "]/div/div[1]/div/a/img")
                image = img.get_attribute("src")
                span1 = driver.find_element_by_xpath("/html/body/div[4]/div[2]/div[2]/div[2]/div[4]/ul/li[" + str(i) + "]/div/div[2]/strong/a/span[2]")
                title = span1.text
                span2 = driver.find_element_by_xpath("/html/body/div[4]/div[2]/div[2]/div[2]/div[4]/ul/li[" + str(i) + "]/div/div[2]/ul/li[1]/span[1]")
                price = span2.text
                span3 = driver.find_element_by_xpath("/html/body/div[4]/div[2]/div[2]/div[2]/div[4]/ul/li[" + str(i) + "]/div/div[2]/ul/li[3]/span")
                description = span3.text
                
                w_desc = link, image, title, price, description
                print(w_desc)
                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
            except:
                time.sleep(0.001)
                
                
    if shopName == "핫핑":
        url = "http://hotping.co.kr/product/list.html?cate_no=25"
        driver.get(url)
        for i in range(1, 100):
            try:
                a = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(i) + "]/div/div[1]/a")
                link = a.get_attribute("href")
                img =driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(i) + "]/div/div[1]/a/img")
                image = img.get_attribute("src")
                span1 = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(i) + "]/div/p/a/span")
                title = span1.text
                span2 = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(i) + "]/div/ul/li[1]/span")
                price = span2.text
                span3 = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div[1]/div[2]/div[2]/div[2]/div[2]/ul/li[" + str(i) + "]/div/ul/li[4]/span")
                description = span3.text
                
                w_desc = link, image, title, price, description
                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
            except:
                time.sleep(0.001)
                
                
    if shopName == "슬로우앤드":
        url = "https://www.slowand.com/category/new/122/"
        driver.get(url)
        for i in range(1, 100):
            try:
                a = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div/div[2]/div[3]/div[2]/ul/li[" + str(i) + "]/div[1]/a")
                link = a.get_attribute("href")
                img =driver.find_element_by_xpath("/html/body/div[2]/div[2]/div/div[2]/div[3]/div[2]/ul/li[" + str(i) + "]/div[1]/a/img")
                image = img.get_attribute("src")
                span1 = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div/div[2]/div[3]/div[2]/ul/li[" + str(i) + "]/div[2]/strong/a/span[2]")
                title = span1.text
                span2 = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div/div[2]/div[3]/div[2]/ul/li[" + str(i) + "]/div[2]/ul/li/span[1]")
                price = span2.text
                span3 = driver.find_element_by_xpath("/html/body/div[2]/div[2]/div/div[2]/div[3]/div[2]/ul/li[" + str(i) + "]/div[2]/ul/li[2]/span")
                description = span3.text
                
                w_desc = link, image, title, price, description
                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
            except:
                time.sleep(0.001)
    
    
    if shopName == "리리앤코":
        url = "https://ririnco.com/product/list.html?cate_no=69"
        driver.get(url)
        for i in range(1, 100):
            try:
                a = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div/div[5]/div[2]/ul/li[" + str(i) + "]/div[1]/a")
                link = a.get_attribute("href")
                img =driver.find_element_by_xpath("/html/body/div[7]/div[2]/div/div[5]/div[2]/ul/li[" + str(i) + "]/div[1]/a/img")
                image = img.get_attribute("src")
                span1 = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div/div[5]/div[2]/ul/li[" + str(i) + "]/div[2]/strong/a/span[2]")
                title = span1.text
                span2 = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div/div[5]/div[2]/ul/li[" + str(i) + "]/div[2]/ul/li[1]/span")
                price = span2.text
                span3 = driver.find_element_by_xpath("/html/body/div[7]/div[2]/div/div[5]/div[2]/ul/li[" + str(i) + "]/div[2]/ul/li[5]/span")
                description = span3.text
            
                w_desc = link, image, title, price, description
                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
            except:
                time.sleep(0.001)
            
            
    if shopName == "로렌하이":
        url = "http://laurenhi.com/product/list.html?cate_no=141"
        driver.get(url)
        count = 1
        
        for i in range(1, 100):
            try:
                a = driver.find_element_by_xpath("/html/body/div[2]/div[3]/div/div[4]/div[2]/ul/li[" + str(i) + "]/div[1]/a")
                link = a.get_attribute("href")
                img =driver.find_element_by_xpath("/html/body/div[2]/div[3]/div/div[4]/div[2]/ul/li[" + str(i) + "]/div[1]/a/img")
                image = img.get_attribute("src")
                span1 = driver.find_element_by_xpath("/html/body/div[2]/div[3]/div/div[4]/div[2]/ul/li[" + str(i) + "]/div[2]/p/a/span[2]")
                title = span1.text
                span2 = driver.find_element_by_xpath("/html/body/div[2]/div[3]/div/div[4]/div[2]/ul/li[" + str(i) + "]/div[2]/ul/li[2]/span[1]")
                price = span2.text
                span3 = driver.find_element_by_xpath("/html/body/div[2]/div[3]/div/div[4]/div[2]/ul/li[" + str(i) + "]/div[2]/ul/li[4]/span")
                description = span3.text
            
                w_desc = link, image, title, price, description
                with open(fDirectory, "a", encoding="utf-8") as f:
                    f.write(str(w_desc))
            except:
                time.sleep(0.001)
        
    driver.quit()
    print("----- " + shopName + " Done! -----")

getNewGoodsLinks("육육걸즈")
#getNewGoodsLinks("핫핑")
#getNewGoodsLinks("슬로우앤드")
#getNewGoodsLinks("리리앤코")
#getNewGoodsLinks("로렌하이")
