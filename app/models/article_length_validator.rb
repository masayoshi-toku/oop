class ArticleLengthValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    validator = Validator.new(record, value, options)
    unless validator.valid?
      record.errors.add attribute.to_sym, "件名と本文で#{options[:minimum]}以上入力してください"
    end

    # ざっくりとやりたいことはこれだけど、雑すぎる
    # if (value.length + record.send(options[:attributes]).length) > options[:minimum]
    #   record.errors.add attribute.to_sym, "件名と本文で#{options[:minimum]}以上入力してください"
    # end
  end

  # クラスで切り出すことによってうまく対応できなかった例外的な振る舞いを考慮に入れることができる
  class Validator
    def initialize(record, value, options)
      @record = record
      @value = value
      @options = options
    end

    def attribute
      @options[:attribute] || ""
    end

    def minimum
      @options[:minimum] || 0
    end

    def value
      @value || ""
    end

    # このメソッドを明確に定義することによって、何を持ってvalidにするのかがわかる
    def valid?
      length > minimum
    end

    def length
      sum = value.length
      sum += @record.send(attribute)&.length unless attribute.blank?
      sum
    end
  end
end
