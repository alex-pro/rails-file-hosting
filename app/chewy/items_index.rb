class ItemsIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      name: {
        tokenizer: 'standard',
        filter: ['lowercase', 'asciifolding']
      }
    }
  }

  define_type Item do
    field :user_id, type: 'integer'
    field :folder_id, type: 'integer'
    field :name, analyzer: 'name'
    field :file, type: 'object'
  end
end
