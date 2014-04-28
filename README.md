# How to use
In your model (activerecord or mongo):

```ruby
class User
  include TranslatedAttributeValue::Base

  # if you have a field called status
  translate_value_for :status

  # more field
  translate_value_for :payments_status, :rule_status
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
```
