# Sinatra Study

### 0.version
- ruby : 2.4.0


### 1. intro-sinatra

- `mkdir sinatra-test`
    - 시나트라 파일을 저장할 폴더 생성
- `cd sinatra-test`
- `touch app.rb`
- `gem install sinatra`
- `ruby app.rb -o $IP`
    - 외부 접속을 허용하기 위해서 IP를 바꿔주기 이거 안하면 리눅스 서버 내에서만 서버가 열림
- `gem install sinatra-contrib`
    - 리로드 자동으로 되게하기
- `gem install sinatra-contrib`

```ruby 
#app.rb -파일에서 작성한 코드

require 'sinatra'

get '/' do
  'Hello world!'
end

#웹에 Hello world 출력```