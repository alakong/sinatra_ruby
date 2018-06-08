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
    menu_img= {"cake"=>"http://www.twosome.co.kr//Twosome_file/PRODUCT/1488_big_img",
    "icecream"=>"https://t1.daumcdn.net/cfile/tistory/25718A375769609E14",
    "waffle"=>"https://assets.simplyrecipes.com/wp-content/uploads/2016/09/Buttermilk-Waffles-vertical-b-1600.jpg" }
    @menu_result=menu.sample
    @menu_img=menu_img[@menu_result]
    erb :lunchhash
end

get '/randomgame' do
    
    random=["학생","농부","백수","아이돌","선생님","회사원","부자","거지","헬스트레이너","개발자","요리사"]
    color={"학생"=>"red","농부"=>"#00b33c","백수"=>"#8c8c8c","아이돌"=>"#d580ff","선생님"=>"#00e6b8",
    "회사원"=>"black","부자"=>"#d580ff","거지"=>"#8c8c8c","헬스트레이너"=>"#00e6b8","개발자"=>"#8c8c8c","요리사"=>"#00b33c"}
    @result=random.sample
    @color=color[@result]
    erb :random
    end