def stub_headers
  {
    'Access-Token' => 'token',
    'Content-Type' => 'application/json;charset=UTF-8',
    'User-Agent' => 'Typhoeus - https://github.com/typhoeus/typhoeus'
  }
end

def stub_get(to, returns)
  stub_request(:get, to).to_return(body: returns.to_json)
end

def stub_post(to, body, returns)
  stub_request(:post, to)
    .with(body: body, headers: stub_headers)
    .to_return(status: 200, body: returns)
end

def stub_patch(to, returns)
  stub_request(:patch, to).to_return(status: 200, body: returns)
end
