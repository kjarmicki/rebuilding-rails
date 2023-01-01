class QuotesController < Rulers::Controller
  def a_quote
    "<div>There is nothing either good or bad but thinking makes it so</div>" +
      "\n<pre>#{env}\n</pre>"
  end

  def exception
    raise "It's a bad one"
  end
end
