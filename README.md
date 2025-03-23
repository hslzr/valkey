# ValKey

Dead simple key-value store.

I needed an excuse to re-learn how to use Sinatra and to play around with
Sequel, so I made this. It's a simple key-value store that uses a SQLite
database to store the data.

## Usage

### Set a value

Values are stored in namespaces. To set a value, you need to specify the
namespace in the URL and the key and value in the POST body.

```
curl -X POST -F 'key=foo' -F 'value=bar' http://127.0.0.1:9292/demo
```

### Get a value

To get a value, you need to specify the namespace and the key in the URL.

```
curl http://127.0.0.1:9292/demo/foo
```

## Setup

1. Clone the repository.
2. Run `bundle install`.
3. Run `bundle exec rackup`.
