package "python-pygments" do
  action :install
end

if %w{ base_directory css_directory pygments_css_file }.all? { |attr| node[attr] }
  css_directory = File.join(node["base_directory"], node["css_directory"])
  directory css_directory do
    action :create
  end

  pygments_css_file = File.join(css_directory, node["pygments_css_file"])

  execute "generate-pygments-css" do
    command "pygmentize -S default -f html > #{pygments_css_file}"
    not_if { File.size?(pygments_css_file) } # do not generate CSS if there is one already
    action :nothing # execute this only after an empty file was created
  end

  file pygments_css_file do
    action :create_if_missing
    notifies :run, "execute[generate-pygments-css]", :immediately
  end
end
