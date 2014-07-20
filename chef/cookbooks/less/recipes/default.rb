bash "less" do
  code "npm install -g less@#{node['less']['version']}"
  not_if "npm list -g | grep less"
end
