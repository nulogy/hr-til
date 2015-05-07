require 'rails_helper'

RSpec.describe PostSlackSerializer, type: :serializer do

  context 'Individual Resource Representation' do
    let(:post) {
      developer = FactoryGirl.build(:developer,
                                   username: "tpope")
      FactoryGirl.build(:post,
                        slug: "sluggishslug",
                        body: "learned some things",
                        developer: developer,
                        title: "entitled title"
                       )
    }

    let(:serializer) { PostSlackSerializer.new(post) }

    let(:serialized){
      JSON.parse(serializer.to_json)['text']
    }

    it 'is serialized correctly' do
      expected_text = "tpope created a new post - <http://www.example.com/posts/sluggishslug-entitled-title|entitled title>"
      expect(serialized).to eql(expected_text)
    end
  end
end
