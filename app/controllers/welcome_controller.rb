# All controller classes in Rails ends with 'Controller' (Rails Convention)
# Controller in Rails inherit (eventually) from ActionController::Base. All the built in controller features of Rails comes from the ActionController::Base class.

# Rails applications come with ApplicationController and by default all generated Rails controlls will inherit from ApplicationController which inherit from ActionController::Base.

class WelcomeController < ApplicationController
    
    def index
    end
    
    def hello
        # render 'welcome/hello'

        # the method here is called a controller action.
        # the convention is that the action will look inside the 'views' folder for a subfolder that matchs the controller name (without the word controller) which is just 'welcome' in this case.
        # then it will look for a view file there named with the action name: 'hello' in this case.It will expect by default that the file has '.html.erb' as an extension. 
            #'.html' because we want to generate an html page. 
            #'.erb' because we're using the default Rails templating system. 
        # Those can be changed later if we want so we can choose to render JSON for istance using another templating system such as 'rabl'

        # in some cases, you may want to render something other than the default. 
        # Let's say we want to render a template called 'hi' instead of 'hello', in such case you will have to use the 'render' method as in:
        # render 'welcome/hi'

        # by default all rails actions will use the layout file:
        # views/layouts/application.html.erb unless you specify something else. 
    end
end
