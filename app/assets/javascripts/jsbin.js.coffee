$.mockjax({
    url: '/nodes/1',
    responseTime: 750,
    responseText: {
      "node": {
        "id": 1,
        "hostname": "localhost",
        "description": "",
        "ips": [ ],
        "created_at": "2014-09-09T18:21:46.000Z",
        "updated_at": "2014-09-09T18:21:46.000Z",
        "token": "63373b41cf913e9f9b3226b4a0452737",
        "access_rule_ids": [
          43,
          44,
          45
        ],
        "security_group_ids": [
          1
        ]
      },
      "access_rules": [
        {
          "id": 46,
          "protocol": "all",
          "ip": "192.168.0.10",
          "port": "23",
          "updated_at": "2014-09-18T21:40:19.000Z",
          "created_at": "2014-09-18T21:40:19.000Z"
        },
        {
          "id": 43,
          "protocol": "all",
          "ip": "192.168.0.10",
          "port": "22",
          "updated_at": "2014-09-18T21:38:17.000Z",
          "created_at": "2014-09-18T21:20:05.000Z"
        },
        {
          "id": 44,
          "protocol": "all",
          "ip": "192.168.0.10",
          "port": "23",
          "updated_at": "2014-09-18T21:38:17.000Z",
          "created_at": "2014-09-18T21:38:17.000Z"
        },
        {
          "id": 45,
          "protocol": "all",
          "ip": "192.168.0.10",
          "port": "23",
          "updated_at": "2014-09-18T21:40:19.000Z",
          "created_at": "2014-09-18T21:40:19.000Z"
        }
      ],
      "security_groups": [
        {
          "id": 1,
          "name": "default",
          "access_rule_ids": [
            46
          ]
        }
      ]
    }
  }
);