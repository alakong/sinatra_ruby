require 'sinatra'
require "sinatra/reloader"


get '/' do
  'Hello world!~~welcome'
end

get '/htmlfile' do
    send_file 'views/htmlfile.html'
    
end

get '/htmltag' do
    '<h1>send html tag</h1>
    <ul><li>cake</li>
    <li>cheese</li></ul>
    '
    
end

get '/welcome/:name' do
 
 "#{params[:name]}님 안녕하세요"

end

get '/cube/:num' do
 a=params[:num].to_i**3
 "<h1>result: #{a}</h1>"
 #=#{params[:num].to_i**3}
end


get '/erbfile' do
   
   @name = "sffds"
   erb :erbfile
   
end


get '/lunch-array' do
    #메뉴들을 배열에 저장한다.
    #하나를 추천한다
    #erb 파일에 담아서 랜더링한다.
    lunch=["cake","cheese","susi","malatang"]
    @lunch=lunch.sample
    # @lunch=lunch.sample(1)이면 "susi" 식으로 그자체가 출력됨
    erb:luncharr
end

get '/lunch-hash' do
    #메뉴들이 저장된 hash배열을 만든다
    #메뉴이름이 키고 사진url이 밸류
    #랜덤으로 하나를 출력한다.
    #이름과 url을 넘겨서 erb를 랜더링한다.
    menu=["cake","icecream","waffle"]
    
    #앞에가 string 일때는 =>으로 해쉬값 설정해야함
    menu_img= {"cake"=> "http://www.twosome.co.kr//Twosome_file/PRODUCT/1488_big_img",
    "icecream"=>"https://t1.daumcdn.net/cfile/tistory/25718A375769609E14",
    "waffle"=>"https://assets.simplyrecipes.com/wp-content/uploads/2016/09/Buttermilk-Waffles-vertical-b-1600.jpg" }
    @menu_result=menu.sample
    puts @menu_result
    @menu_img=menu_img[@menu_result]
    erb :lunchhash
end
