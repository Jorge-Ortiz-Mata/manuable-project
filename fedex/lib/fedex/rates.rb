def body_params(account_id, params)
  {
    "accountNumber": {
        "value": "#{account_id}"
    },
    "requestedShipment": {
      "currency": "mxn",
      "preferredCurrency": "NMP",
      "shipper": {
        "address": address_params(params['address_from'])
      },
      "recipient": {
        "address": address_params(params['address_to'])
      },
      "pickupType": "DROPOFF_AT_FEDEX_LOCATION",
      "packagingType": "YOUR_PACKAGING",
      "rateRequestType": [
        "LIST",
        "ACCOUNT"
      ],
      "requestedPackageLineItems": [
        {
          "weight": weight_params(params['parcel']),
          "dimensons": parcel_params(params['parcel'])
        }
      ]
    }
  }.to_json
end

def address_params(params)
  {
    'countryCode': params['country'].upcase,
    'postalCode': params['zip'].to_i
  }
end

def parcel_params(params)
  {
    'length': params['length'].to_f,
    'height': params['height'].to_f,
    'distance_unit': params['distance_unit'].upcase,
    'width': params['width'].to_f
  }
end

def weight_params(params)
  {
    'units': params['mass_unit'].upcase,
    'value': params['weight'].to_f
  }
end

def build_reponse(response)
  new_response = Array.new

  JSON.parse(response.body)['output']['rateReplyDetails'].each do |detail|
    new_response << {
      "price": (detail['ratedShipmentDetails'][0]['totalNetCharge'] * 18.01).round(2),
      "currency": "mxn",
      "service_level": {
        "name": detail['serviceType'].humanize,
        "token": detail['serviceType']
      }
    }
  end

  JSON.parse(new_response.to_json)
end
