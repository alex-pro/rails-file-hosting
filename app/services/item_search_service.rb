class ItemSearchService
  def initialize(query = nil)
    @query = query
  end

  def search
    [query_string].compact.reduce(:merge)
  end

  private

  def index
    ItemsIndex
  end

  def query_string
    index.query(query_string: { fields: [:name], query: @query, default_operator: 'and'}) if @query.present?
  end

  #def country_filter
    #index.filter(term: { country_id: @country.id })
  #end

  #def price_filter
    #body = {}.tap do |body|
      #body.merge!(gte: @params[:min_price].to_i) if @params[:min_price].present?
      #body.merge!(lte: @params[:max_price].to_i) if @params[:max_price].present?
    #end
    #index.filter(range: { min_price: body }) if body.present?
  #end
end
