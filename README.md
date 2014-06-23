# How to use
If you are using ActiveRecord or Mongoid, translated attribute value will be included by default, else you have to include TranslatedAttributeValue::Base in your model class:

```ruby
class User
  include TranslatedAttributeValue::Base
  # model related code
end
```

And then your can translate the attribute as following:

## Activerecord
```yaml
pt-BR:
  activerecord:
    attributes:
      user:
        status_translation:
          value1: 'Translation for value1'
          value2: 'Translation for value2'
```

## Mongoid
```yaml
pt-BR:
  mongoid:
    attributes:
      user:
        status_translation:
          value1: 'Translation for value1'
          value2: 'Translation for value2'
```

## Otherwise
```yaml
pt-BR:
  translated_attribute_value:
    user:
      status_translation:
        value1: 'Translation for value1'
        value2: 'Translation for value2'
```

Anywhere in your code you can call
```ruby
  user = User.new
  user.status = 'value1'
  user.status_translated
  #=> 'Translation for value1'
```
