    {
      "resource"=>"/collections/3918056102",
      "user_id"=>143864914,
      "topic"=>"payments", 
      "application_id"=>6348330433367390, 
      "attempts"=>1, 
      "sent"=>"2018-07-10T18:29:24.737Z", 
      "received"=>"2018-07-10T18:29:24.661Z", 
      "suscription"=>{
        "user_id"=>143864914
      }
    }
    Started POST "/mercado_pago_transactions/webhook?type=payment&data.id=3920814063" for 216.33.196.4 at 2018-07-11 13:22:48 +0000
    Processing by MercadoPagoTransactionsController#webhook as HTML
    Parameters: {
      "data"=>{"id"=>"3920814063"},
      "date_created"=>"2018-07-11T09:22:43.000-04:00", 
      "type"=>"payment", 
      "api_version"=>"v1", 
      "id"=>310767412, 
      "user_id"=>143864914, 
      "live_mode"=>true, 
      "data.id"=>"3920814063", 
      "mercado_pago_transaction"=>{
        "id"=>310767412, 
        "date_created"=>"2018-07-11T09:22:43.000-04:00", 
        "user_id"=>143864914
      }
    }
    Started POST "/suscriptions/notification" for 216.33.196.4 at 2018-07-11 13:22:48 +0000
    Processing by SuscriptionsController#notification as JSON
    Parameters: {
      "resource"=>"/collections/3920814063", 
      "user_id"=>143864914, 
      "topic"=>"payments", 
      "application_id"=>6348330433367390, 
      "attempts"=>1, 
      "sent"=>"2018-07-11T13:22:48.032Z", 
      "received"=>"2018-07-11T13:22:47.979Z", 
      "suscription"=>{"user_id"=>143864914}
    }

  {
    "resource"=>"/collections/3910632083",
    "user_id"=>243385631, 
    "topic"=>"payments", 
    "application_id"=>6348330433367390, 
    "attempts"=>1, 
    "sent"=>"2018-07-11T13:24:16.743Z", 
    "received"=>"2018-07-11T13:24:16.712Z", 
    "suscription"=>{"user_id"=>243385631}
  }

  {
    "resource"=>"/collections/3906921726", 
    "user_id"=>243385631, 
    "topic"=>"payments", 
    "application_id"=>6348330433367390, 
    "attempts"=>1, 
    "sent"=>"2018-07-11T13:28:09.210Z", 
    "received"=>"2018-07-11T13:28:09.172Z", 
    "suscription"=>{"user_id"=>243385631}
  }


#-------------------
{
  "resource"=>"/collections/3921522360", 
  "user_id"=>143864914, 
  "topic"=>"payments", 
  "application_id"=>6348330433367390, 
  "attempts"=>1, 
  "sent"=>"2018-07-11T15:30:06.428Z", 
  "received"=>"2018-07-11T15:30:06.360Z", 
  "suscription"=>{
    "user_id"=>143864914
  }
}
{
  "data"=>{"id"=>"3921522360"}, 
  "date_created"=>"2018-07-11T11:30:03.000-04:00", 
  "type"=>"payment", 
  "api_version"=>"v1", 
  "id"=>310838839, 
  "user_id"=>143864914, 
  "live_mode"=>true, 
  "data.id"=>"3921522360", 
  "mercado_pago_transaction"=>{
    "id"=>310838839, 
    "date_created"=>"2018-07-11T11:30:03.000-04:00", 
    "user_id"=>143864914
  }
}
#PAYMENT
{
  "status"=>"200", 
  "response"=>{
    "id"=>3921522360, 
    "date_created"=>"2018-07-11T11:30:03.000-04:00", 
    "date_approved"=>nil, 
    "date_last_updated"=>"2018-07-11T11:30:04.000-04:00", 
    "date_of_expiration"=>nil, 
    "money_release_date"=>nil, 
    "operation_type"=>"recurring_payment", 
    "issuer_id"=>"297", 
    "payment_method_id"=>"visa", 
    "payment_type_id"=>"credit_card", 
    "status"=>"in_process", 
    "status_detail"=>"pending_contingency", 
    "currency_id"=>"ARS", 
    "description"=>nil, 
    "live_mode"=>true, 
    "sponsor_id"=>nil, 
    "authorization_code"=>nil, 
    "money_release_schema"=>nil, 
    "counter_currency"=>nil, 
    "collector_id"=>143864914, 
    "payer"=>{
      "type"=>"customer", 
      "id"=>"335768617-EscOkWO1EO9ZDu", 
      "operator_id"=>nil, 
      "email"=>nil, 
      "phone"=>{}, 
      "first_name"=>nil, 
      "last_name"=>nil, 
      "entity_type"=>nil, 
      "identification"=>{}
    }, 
    "metadata"=>{
      "subscription_id"=>"f4f958103b1741148419719662499a26", 
      "invoice_id"=>"354e14691a674609a0d5ad737d31883c", 
      "plan_id"=>"e8f7bf307a6e49c4920bc02b8ecdd380"
    }, 
    "additional_info"=>{}, 
    "order"=>{}, 
    "external_reference"=>nil, 
    "transaction_amount"=>1, 
    "transaction_amount_refunded"=>0, 
    "coupon_amount"=>0, 
    "differential_pricing_id"=>nil, 
    "deduction_schema"=>nil, 
    "transaction_details"=>{
      "net_received_amount"=>0, 
      "total_paid_amount"=>1, 
      "overpaid_amount"=>0, 
      "external_resource_url"=>nil, 
      "installment_amount"=>1, 
      "financial_institution"=>nil, 
      "payment_method_reference_id"=>nil, 
      "payable_deferral_period"=>nil, 
      "acquirer_reference"=>nil
    }, 
    "fee_details"=>[], 
    "captured"=>true, 
    "binary_mode"=>false, 
    "call_for_authorize_id"=>nil, 
    "statement_descriptor"=>nil, 
    "installments"=>1, 
    "card"=>{
      "id"=>"274085751", 
      "first_six_digits"=>"469771", 
      "last_four_digits"=>"5001", 
      "expiration_month"=>11, 
      "expiration_year"=>2023, 
      "date_created"=>"2018-07-11T09:15:23.000-04:00", 
      "date_last_updated"=>"2018-07-11T09:15:23.000-04:00", 
      "cardholder"=>{
        "name"=>"Ana Maria Martinez", 
        "identification"=>{
          "number"=>"5891058", 
          "type"=>"DNI"
        }
      }
    }, 
    "notification_url"=>nil, 
    "refunds"=>[], 
    "processing_mode"=>"aggregator", 
    "merchant_account_id"=>nil, 
    "acquirer"=>nil, 
    "merchant_number"=>nil, 
    "acquirer_reconciliation"=>[]
  }
} 

#SUSCRIPTION
{
  "status"=>"200", 
  "response"=>{
    "id"=>"f4f958103b1741148419719662499a26", 
    "plan_id"=>"e8f7bf307a6e49c4920bc02b8ecdd380", 
    "payer"=>{
      "id"=>"335768617-EscOkWO1EO9ZDu", 
      "type"=>"customer", 
      "email"=>"djpelonn@gmail.com", 
      "identification"=>{
        "type"=>"null", 
        "number"=>"null"
      }
    }, 
    "application_fee"=>nil, 
    "status"=>"authorized", 
    "description"=>nil, 
    "external_reference"=>nil, 
    "date_created"=>"2018-07-11T11:30:02.000-04:00", 
    "last_modified"=>"2018-07-11T11:30:03.000-04:00", 
    "live_mode"=>true, 
    "start_date"=>"2018-07-11T11:30:02.000-04:00", 
    "end_date"=>nil, 
    "metadata"=>{}, 
    "charges_detail"=>{
      "invoices"=>[
        {
          "id"=>"354e14691a674609a0d5ad737d31883c", 
          "period"=>"2018-07-11"
        }
      ], 
      "last_charged_date"=>nil, 
      "last_charged_amount"=>nil, 
      "pending_charge_amount"=>nil, 
      "pending_charge_periods"=>nil, 
      "charged_periods"=>0, 
      "charged_amount"=>0.0, 
      "debt_periods"=>0, 
      "debt_amount"=>0.0, 
      "next_payment_date"=>"2018-07-11T11:30:02.000-04:00"
    }, 
    "setup_fee"=>nil
  }
} 

#INVOICE
{
  "status"=>"200", 
  "response"=>{
    "id"=>"354e14691a674609a0d5ad737d31883c", 
    "plan_id"=>"e8f7bf307a6e49c4920bc02b8ecdd380", 
    "subscription_id"=>"f4f958103b1741148419719662499a26", 
    "payer"=>{
      "id"=>"335768617-EscOkWO1EO9ZDu", 
      "type"=>"customer", 
      "email"=>"djpelonn@gmail.com", 
      "identification"=>{"type"=>"null", 
        "number"=>"null"
      }
    }, 
    "application_fee"=>nil, 
    "status"=>"dunning", 
    "description"=>nil, 
    "external_reference"=>nil, 
    "date_created"=>"2018-07-11T11:30:03.000-04:00", 
    "last_modified"=>"2018-07-11T11:30:04.000-04:00", 
    "live_mode"=>true, 
    "metadata"=>{}, 
    "payments"=>[
      {
        "id"=>"3921522360", 
        "status"=>"in_process", 
        "status_detail"=>"pending_contingency", 
        "attempt_date"=>"2018-07-11T11:30:04.344-04:00"
      }
    ], 
    "debit_date"=>"2018-07-11T11:30:02.000-04:00", 
    "next_payment_attempt"=>"2018-07-11T11:30:02.000-04:00"
  }
}


{"data": {"id": 3922796727}, "date_created": "2018-07-11T15:22:58.000-04:00", "type": "payment", "api_version": "v1", "id": 311327692, "user_id": 143864914, "live_mode": true, "data.id": "3922796727", "mercado_pago_transaction": {"id": 311327692, "date_created": "2018-07-11T15:22:58.000-04:00", "user_id": 143864914}}


{"status"=>"200", "response"=>{"collection"=>{"id"=>3922796727, "site_id"=>"MLA", "date_created"=>"2018-07-11T15:22:58.000-04:00", "date_approved"=>nil, "money_release_date"=>nil, "last_modified"=>"2018-07-11T15:22:59.000-04:00", "payer"=>{"id"=>335768617, "first_name"=>"", "last_name"=>"301654.djpelonn", "phone"=>{"area_code"=>nil, "number"=>nil, "extension"=>""}, "identification"=>{"type"=>nil, "number"=>nil}, "email"=>"301654.djpelonn@gmail.com", "nickname"=>"@335768617"}, "order_id"=>nil, "external_reference"=>nil, "merchant_order_id"=>nil, "reason"=>nil, "currency_id"=>"ARS", "transaction_amount"=>1, "net_received_amount"=>0, "total_paid_amount"=>1, "shipping_cost"=>0, "coupon_amount"=>0, "coupon_fee"=>0, "finance_fee"=>0, "discount_fee"=>0, "coupon_id"=>nil, "status"=>"in_process", "status_detail"=>"offline_process", "installments"=>1, "issuer_id"=>297, "installment_amount"=>1, "deferred_period"=>nil, "payment_type"=>"credit_card", "marketplace"=>"NONE", "operation_type"=>"recurring_payment", "transaction_order_id"=>nil, "statement_descriptor"=>nil, "cardholder"=>{"name"=>"Ana Maria Martinez", "identification"=>{"number"=>"5891058", "type"=>"DNI"}}, "authorization_code"=>nil, "marketplace_fee"=>0, "deduction_schema"=>nil, "refunds"=>[], "amount_refunded"=>0, "last_modified_by_admin"=>nil, "api_version"=>"2", "concept_id"=>nil, "concept_amount"=>0, "internal_metadata"=>{}, "collector"=>{"id"=>143864914, "first_name"=>"Facundo", "last_name"=>"Díaz Martínez", "phone"=>{"area_code"=>nil, "number"=>"387 4242177", "extension"=>"(0387)154"}, "email"=>"facundo_diaz_martinez@hotmail.com", "nickname"=>"FACUNDODAZMARTNEZ"}}}} 




Payment = {
  "id"                                        => 3920814063, 
  "date_created"                              => "2018-07-11T09:22:43.000-04:00", 
  "date_approved"                             => "2018-07-13T09:23:38.000-04:00", 
  "collector_id"                              => 143864914, 
  "description"                               => nil, 
  "currency_id"                               => "ARS", 
  "operation_type"                            => "recurring_payment", 
  "transaction_amount"                        => 1, 
  "transaction_amount_refunded"               => 0, 
  "status"                                    => "approved", 
  "status_detail"                             => "accredited", 
  "application_fee"                           => nil, 
  "payment_type_id"                           => "credit_card", 
  "payment_method_id"                         => "visa", 
  "card_id"                                   => "274085751", 
  "installments"                              => 1, 
  "transaction_details_net_received_amount"   => 0.95, 
  "transaction_details_total_paid_amount"     => 1, 
  "transaction_details_installment_amount"    => 1, 
  "refunds_id"                                => 0, 
  "refunds_payment_id"                        => 0, 
  "refunds_amount"                            => 0.0, 
  "refunds_source_id"                         => "", 
  "refunds_source_name"                       => "", 
  "refunds_date_created"                      => nil
}


{
  "status"=>"200", 
  "response"=>{
    "id"=>"1683c607cd754f09963aea961af24a62", 
    "plan_id"=>"e8f7bf307a6e49c4920bc02b8ecdd380", 
    "payer"=>{
      "id"=>"152197304-TibRN8DwaosV2S", 
      "type"=>"customer", 
      "email"=>"arielg2094@gmail.com", 
      "identification"=>{
        "type"=>"null", "number"=>"null"
      }
    }, 
    "application_fee"=>nil, 
    "status"=>"authorized", 
    "description"=>nil, 
    "external_reference"=>nil, 
    "date_created"=>"2018-07-17T09:08:39.000-04:00", 
    "last_modified"=>"2018-07-17T09:08:39.000-04:00", 
    "live_mode"=>true, "start_date"=>"2018-07-17T09:08:39.000-04:00", 
    "end_date"=>nil, 
    "metadata"=>{}, 
    "charges_detail"=>{
      "invoices"=>[
        {
          "id"=>"05576224d2804118aa1af152c438c93d", 
          "period"=>"2018-07-17"
        }
      ], 
      "last_charged_date"=>nil, 
      "last_charged_amount"=>nil, 
      "pending_charge_amount"=>nil, 
      "pending_charge_periods"=>nil, 
      "charged_periods"=>0, 
      "charged_amount"=>0.0, 
      "debt_periods"=>0, 
      "debt_amount"=>0.0, 
      "next_payment_date"=>"2018-07-17T09:08:39.000-04:00"
    }, 
    "setup_fee"=>nil
  }
}

