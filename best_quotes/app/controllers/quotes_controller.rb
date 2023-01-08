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
    file_model = FileModel.create(attrs)
    render :quote, { obj: file_model }
  end

  def update_quote
    id = 3
    file_model = FileModel.find(id)
    file_model['id'] = id
    file_model['submitter'] = 'somebody'
    updated_model = FileModel.update(file_model)
    render :quote, { obj: updated_model }
  end

  def a_quote
    render :a_quote, {
      noun: :winking,
      controller_name: self.class.name,
      rulers_gem_version: Rulers::VERSION
    }
  end

  def show
    quote = FileModel.find(params['id'])
    render_response :quote, { obj: quote }
  end

  def quotes_by_somebody
    quotes = FileModel.find_all_by_submitter('somebody')
    render :index, { quotes: quotes }
  end

  def exception
    raise "It's a bad one"
  end
end
