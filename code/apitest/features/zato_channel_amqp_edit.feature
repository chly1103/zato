@channel.amqp
Feature: zato.channel.amqp.edit
 Updates an already existing AMQP channel. The channel will be stopped. If ‘is_active’ flag is ‘true’, the underlying 
 AMQP consumer will then be started.


  @channel.amqp.edit
  Scenario: Setup
    Given I store a random string under "chan_name"
    Given I store a random string under "edited_chan_name"


  @channel.amqp.edit
  Scenario: Create amqp definition
    Given address "$ZATO_API_TEST_SERVER"
    Given Basic Auth "$ZATO_API_TEST_PUBAPI_USER" "$ZATO_API_TEST_PUBAPI_PASSWORD"

    Given URL path "/zato/json/zato.definition.amqp.create"

    Given format "JSON"
    Given request is "{}"
    Given JSON Pointer "/cluster_id" in request is "$ZATO_API_TEST_CLUSTER_ID"
    Given JSON Pointer "/name" in request is a random string
    Given JSON Pointer "/host" in request is "localhost"
    Given JSON Pointer "/port" in request is "5672"
    Given JSON Pointer "/vhost" in request is "/dev"
    Given JSON Pointer "/username" in request is "test_user"
    Given JSON Pointer "/frame_max" in request is "131072"
    Given JSON Pointer "/heartbeat" in request is "0"

    When the URL is invoked

    Then status is "200"
    And JSON Pointer "/zato_env/result" is "ZATO_OK"

    And I store "/zato_definition_amqp_create_response/id" from response under "amqp_def_id"
    And JSON Pointer "/zato_definition_amqp_create_response/id" is any integer
    And I sleep for "2"


  @channel.amqp.edit
  Scenario: Create a new amqp channel

    Given address "$ZATO_API_TEST_SERVER"
    Given Basic Auth "$ZATO_API_TEST_PUBAPI_USER" "$ZATO_API_TEST_PUBAPI_PASSWORD"

    Given URL path "/zato/json/zato.channel.amqp.create"

    Given format "JSON"
    Given request is "{}"

    Given JSON Pointer "/cluster_id" in request is "$ZATO_API_TEST_CLUSTER_ID"
    Given JSON Pointer "/name" in request is "#chan_name"
    Given JSON Pointer "/is_active" in request is "true"
    Given JSON Pointer "/def_id" in request is "#amqp_def_id"
    Given JSON Pointer "/queue" in request is a random string
    Given JSON Pointer "/consumer_tag_prefix" in request is a random string
    Given JSON Pointer "/service" in request is "zato.ping"
    Given JSON Pointer "/data_format" in request is "json"

    When the URL is invoked

    Then status is "200"
    And JSON Pointer "/zato_env/result" is "ZATO_OK"
    And I store "/zato_channel_amqp_create_response/id" from response under "channel_id"
    And I store "/zato_channel_amqp_create_response/name" from response under "#chan_name"
    And I sleep for "2"

  @channel.amqp.edit
  Scenario: Edit amqp channel

    Given address "$ZATO_API_TEST_SERVER"
    Given Basic Auth "$ZATO_API_TEST_PUBAPI_USER" "$ZATO_API_TEST_PUBAPI_PASSWORD"

    Given URL path "/zato/json/zato.channel.amqp.edit"

    Given format "JSON"
    Given request is "{}"

    Given JSON Pointer "/cluster_id" in request is "$ZATO_API_TEST_CLUSTER_ID"
    Given JSON Pointer "/id" in request is "#channel_id"
    Given JSON Pointer "/name" in request is "#edited_chan_name"
    Given JSON Pointer "/is_active" in request is "true"
    Given JSON Pointer "/def_id" in request is "#amqp_def_id"
    Given JSON Pointer "/queue" in request is a random string
    Given JSON Pointer "/consumer_tag_prefix" in request is a random string
    Given JSON Pointer "/service" in request is "zato.ping"
    Given JSON Pointer "/data_format" in request is "json"

    When the URL is invoked

    Then status is "200"
    And JSON Pointer "/zato_env/result" is "ZATO_OK"
    And I store "/zato_channel_amqp_edit_response/id" from response under "channel_id"
    And I store "/zato_channel_amqp_edit_response/name" from response under "#edited_chan_name"
    And I sleep for "2"


  @channel.amqp.edit
  Scenario: Delete amqp channel

    Given address "$ZATO_API_TEST_SERVER"
    Given Basic Auth "$ZATO_API_TEST_PUBAPI_USER" "$ZATO_API_TEST_PUBAPI_PASSWORD"

    Given URL path "/zato/json/zato.channel.amqp.delete"

    Given format "JSON"
    Given request is "{}"
    Given JSON Pointer "/id" in request is "#channel_id"

    When the URL is invoked

    Then status is "200"
    And JSON Pointer "/zato_env/result" is "ZATO_OK"


  @channel.amqp.edit
  Scenario: Delete amqp definition
    Given address "$ZATO_API_TEST_SERVER"
    Given Basic Auth "$ZATO_API_TEST_PUBAPI_USER" "$ZATO_API_TEST_PUBAPI_PASSWORD"

    Given URL path "/zato/json/zato.definition.amqp.delete"

    Given format "JSON"
    Given request is "{}"
    Given JSON Pointer "/id" in request is "#amqp_def_id"
    When the URL is invoked

    Then status is "200"
    And JSON Pointer "/zato_env/result" is "ZATO_OK"


