class QuotesController < Rulers::Controller
  def index
    quotes = FileModel.all
    render :index, { quotes: quotes }
  end

  def new_quote
    attrs = {
      'submitter' => 'web user',
      'quote' => 'a picture is worth a thousand pixels',
      'attribution' => 'me'
    }
    m = FileModel.create(attrs)
    render :quote, { obj: m }
  end

  def a_quote
    render :a_quote, {
      noun: :winking,
      controller_name: self.class.name,
      rulers_gem_version: Rulers::VERSION
    }
  end

  def quote_1
    quote_1 = FileModel.find(1)
    render :quote, { obj: quote_1 }
  end

  def exception
    raise "It's a bad one"
  end
end
