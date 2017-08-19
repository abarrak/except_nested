require "spec_helper"

RSpec.describe ExceptNested do
  it "has a version number" do
    expect(ExceptNested::VERSION).not_to be nil
    expect(ExceptNested::VERSION).to be_kind_of(String)
  end

  describe "#except_nested extension to hash" do
    subject { { name: 'Zohoor', preferences: { color: 'mauve', drink: 'coffee', pet: 'cat' },
                degree: 'Psychology' } }

    it "accepts normal keys list like #except and filter accordingly" do
      filtered_one = subject.except_nested(:degree)
      expect(filtered_one).not_to eq(subject)
      expect(filtered_one).to have_key(:name)
      expect(filtered_one).to include({ name: 'Zohoor' })
      expect(filtered_one).to have_key(:preferences)
      expect(filtered_one).to include({ preferences: { color: 'mauve', drink: 'coffee', pet: 'cat' } })
      expect(filtered_one.size).to eq(2)

      filtered_two = subject.except_nested(:degree, :preferences)
      expect(filtered_two).not_to eq(subject)
      expect(filtered_two).not_to eq(filtered_one)
      expect(filtered_two).to have_key(:name)
      expect(filtered_two).to include({ name: 'Zohoor' })
      expect(filtered_two).not_to have_key(:degree)
      expect(filtered_two).not_to have_key(:preferences)
      expect(filtered_two.size).to eq(1)
    end

    it "accepts nested keys list and filter accordingly" do
      filtered = subject.except_nested(preferences: [:color, :drink])

      expect(filtered).not_to eq(subject)
      expect(filtered).to have_key(:name)
      expect(filtered).to have_key(:degree)
      expect(filtered).to have_key(:preferences)
      expect(filtered).to include({ name: 'Zohoor', degree: 'Psychology' })

      expect(filtered[:preferences]).to have_key(:pet)
      expect(filtered[:preferences]).not_to have_key(:drink)
      expect(filtered[:preferences]).not_to have_key(:color)
      expect(filtered[:preferences]).to include({ pet: 'cat' })
      expect(filtered[:preferences]).not_to include({ color: 'mauve', drink: 'coffee' })
    end

    it "accepts keys list with single nested key and filter accordingly" do
      filtered = subject.except_nested(preferences: :drink)

      expect(filtered).not_to eq(subject)
      expect(filtered).to have_key(:name)
      expect(filtered).to have_key(:degree)
      expect(filtered).to have_key(:preferences)
      expect(filtered).to include({ name: 'Zohoor', preferences: { color: 'mauve', pet: 'cat' },
                                    degree: 'Psychology' })

      expect(filtered[:preferences]).to have_key(:pet)
      expect(filtered[:preferences]).to have_key(:color)
      expect(filtered[:preferences]).not_to have_key(:drink)
    end

    it "return the same hash with empty key arguments" do
      f = subject.except_nested()
      expect(f).to eq(subject)
      expect(f.size).to eq(3)
      expect(f.keys).to eq([:name, :preferences, :degree])

      f = subject.except_nested([])
      expect(f).to eq(subject)
      expect(f.size).to eq(3)
      expect(f.keys).to eq([:name, :preferences, :degree])

      f = subject.except_nested({})
      expect(f).to eq(subject)
      expect(f.size).to eq(3)
      expect(f.keys).to eq([:name, :preferences, :degree])
    end

    it "return empty hash if all keys are excepted" do
      f = subject.except_nested(:name, :preferences, :degree)
      expect(f).not_to eq(subject)
      expect(f).to be_empty
      expect(f.size).to eq(0)
    end

    context "3-level nested" do
      subject { { a: 1, b: { b1: true, b2: false }, c: { d: { x: 100, y: 200 }, e: true } } }

      it "accepts nested keys list in and filter accordingly" do
        f = subject.except_nested(c: { d: :x })

        expect(f).not_to eq(subject)
        [:a, :b, :c].each do |k|
          expect(f).to have_key(k)
        end

        expect(f[:c]).to have_key(:d)
        expect(f[:c]).to have_key(:e)

        expect(f[:c][:d]).to have_key(:y)
        expect(f[:c][:d]).not_to have_key(:x)
        expect(f).to include({ c: { d: { y: 200 }, e: true } })
      end
    end
  end
end
