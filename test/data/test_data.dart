import 'package:fixnum/fixnum.dart';

import 'package:bolt11_decoder/bolt11_decoder.dart';

List testData = [
  {
    'request':
        'lnsb20300n1pdarmakpp57zzavxfm39rzg9juc6awru0zfgxvdaewkdupkmmw0x787ds0k04sdqcvdex2ct5v4jzq6twyp3k7er9cqzys7d9uyytydxmsqdz6h9s9wlu2276hjsysa3upu0mz0k55el5323634yjasmnep6hkmyh93ke6nj0v9p3rzgyl5wwu2cfplyg5wv9wdycqaaejt7',
    'prefix': PayRequestPrefix.lnsb,
    'amount': 0.00002030,
    'timestamp': Int64.parseInt('1540485046'),
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            'f085d6193b894624165cc6bae1f1e24a0cc6f72eb3781b6f6e79bc7f360fb3eb'
      },
      {'type': 'description', 'data': 'created in code'},
      {'type': 'min_final_cltv_expiry', 'data': 144}
    ],
    'signature':
        'f34bc2116469b700345ab960577f8a57b5794090ec781e3f627da94cfe9154751a925d86e790eaf6d92e58db3a9c9ec286231209fa39dc56121f9114730ae69300',
    'pubKey':
        '0208c49665537360e0f94a6403ac2c2776b4ea87b66c084f9f52bf7014f80c6238'
  },
  {
    'request':
        'lnbc10u1pdsw4dkpp5mmlhfpcw4rj0scnyqmw02yvwpn4h6d40wyep3yew8l954sfl6ucqdqqcqzysxqrrssaayzylslcav0sr3c7237mwea5k67vk7t3j6pdmvnuuadxy0dsj5zalg6merxgndc74nc753lnuyx7t2sjecfpxp820r9use77n7vyqcpp7dlfy',
    'prefix': PayRequestPrefix.lnbc,
    'amount': 0.00001,
    'timestamp': Int64.parseInt('1527207350'),
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            'deff74870ea8e4f8626406dcf5118e0ceb7d36af713218932e3fcb4ac13fd730'
      },
      {'type': 'description', 'data': ''},
      {'type': 'min_final_cltv_expiry', 'data': 144},
      {'type': 'expiry', 'data': 3600}
    ],
    'signature':
        'ef48227e1fc758f80e38f2a3edbb3da5b5e65bcb8cb416ed93e73ad311ed84a82efd1ade46644db8f5678f523f9f086f2d50967090982753c65e433ef4fcc20301'
  },
  {
    'request':
        'lnbc1380n1pdcc6z6pp5fu7qgkud3t6shtd49peznfxcme7f8evnnk3gzycpnl4fa0ryffhsdp2g3hkuct5d9hkugr5dusyu6trdakxzueqg3hhy6t9wgxqrpc8cqp2sh2w9xuyttya829nauh96cutmkzmrjw2m6rsf4n4tx86u4zt7nd3c6tew67ff8vn5rmr3nyxscndcwutx47adly0jymev0w764kw2aqphuszdt',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1535928410'),
    'amount': 0.00000138,
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            '4f3c045b8d8af50badb5287229a4d8de7c93e5939da28113019fea9ebc644a6f'
      },
      {'type': 'description', 'data': 'Donation to Nicolas Dorier'},
      {'type': 'expiry', 'data': 1799},
      {'type': 'min_final_cltv_expiry', 'data': 10}
    ],
    'pubKey':
        '02634b5d6b7db0cf26025bb59ddf1eafed2f1857de3550c129cfd7dbfb403c4e0f',
    'signature':
        '85d4e29b845ac9d3a8b3ef2e5d638bdd85b1c9cade8704d675598fae544bf4db1c697976bc949d93a0f638cc868626dc3b8b357dd6fc8f9137963dded56ce57401'
  },
  {
    'request':
        'lnbc1pvjluezpp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdpl2pkx2ctnv5sxxmmwwd5kgetjypeh2ursdae8g6twvus8g6rfwvs8qun0dfjkxaq8rkx3yf5tcsyz3d73gafnh3cax9rn449d9p5uxz9ezhhypd0elx87sjle52x86fux2ypatgddc6k63n7erqz25le42c4u4ecky03ylcqca784w',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0,
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {'type': 'description', 'data': 'Please consider supporting this project'}
    ],
    'pubKey':
        '03e7156ae33b0a208d0744199163177e909e80176e55d97a2f221ede0f934dd9ad',
    'signature':
        '38ec6891345e204145be8a3a99de38e98a39d6a569434e1845c8af7205afcfcc7f425fcd1463e93c32881ead0d6e356d467ec8c02553f9aab15e5738b11f127f00'
  },
  {
    'request':
        'lnbc2500u1pvjluezpp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdq5xysxxatsyp3k7enxv4jsxqzpuaztrnwngzn3kdzw5hydlzf03qdgm2hdq27cqv3agm2awhz5se903vruatfhq77w3ls4evs3ch9zw97j25emudupq63nyw24cg27h2rspfj9srp',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0.0025,
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {'type': 'description', 'data': '1 cup coffee'},
      {'type': 'expiry', 'data': 60}
    ],
    'signature':
        'e89639ba6814e36689d4b91bf125f10351b55da057b00647a8dabaeb8a90c95f160f9d5a6e0f79d1fc2b964238b944e2fa4aa677c6f020d466472ab842bd750e01'
  },
  {
    'request':
        'lnbc2500u1pvjluezpp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqdpquwpc4curk03c9wlrswe78q4eyqc7d8d0xqzpuyk0sg5g70me25alkluzd2x62aysf2pyy8edtjeevuv4p2d5p76r4zkmneet7uvyakky2zr4cusd45tftc9c5fh0nnqpnl2jfll544esqchsrny',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0.0025,
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {'type': 'description', 'data': 'ナンセンス 1杯'},
      {'type': 'expiry', 'data': 60}
    ],
    'signature':
        '259f04511e7ef2aa77f6ff04d51b4ae9209504843e5ab9672ce32a153681f687515b73ce57ee309db588a10eb8e41b5a2d2bc17144ddf398033faa49ffe95ae600'
  },
  {
    'request':
        'lnbc20m1pvjluezpp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqscc6gd6ql3jrc5yzme8v4ntcewwz5cnw92tz0pc8qcuufvq7khhr8wpald05e92xw006sq94mg8v2ndf4sefvf9sygkshp5zfem29trqq2yxxz7',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0.02,
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {
        'type': 'purpose_hash',
        'data':
            '3925b6f67e2c340036ed12093dd44e0368df1b6ea26c53dbe4811f58fd5db8c1'
      }
    ],
    'signature':
        'c63486e81f8c878a105bc9d959af1973854c4dc552c4f0e0e0c7389603d6bdc67707bf6be992a8ce7bf50016bb41d8a9b5358652c4960445a170d049ced4558c00'
  },
  {
    'request':
        'lntb20m1pvjluezhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqspp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqfpp3x9et2e20v6pu37c5d9vax37wxq72un98kmzzhznpurw9sgl2v0nklu2g4d0keph5t7tj9tcqd8rexnd07ux4uv2cjvcqwaxgj7v4uwn5wmypjd5n69z2xm3xgksg28nwht7f6zspwp3f9t',
    'prefix': PayRequestPrefix.lntb,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0.02,
    'tagged': [
      {
        'type': 'purpose_hash',
        'data':
            '3925b6f67e2c340036ed12093dd44e0368df1b6ea26c53dbe4811f58fd5db8c1'
      },
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {
        'type': 'fallback_address',
        'data': '173172b5654f6683c8fb146959d347ce303cae4ca7'
      }
    ],
    'signature':
        'b6c42b8a61e0dc5823ea63e76ff148ab5f6c86f45f9722af0069c7934daff70d5e315893300774c897995e3a7476c8193693d144a36e2645a0851e6ebafc9d0a01'
  },
  {
    'request':
        'lnbc20m1pvjluezpp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqsfpp3qjmp7lwpagxun9pygexvgpjdc4jdj85fr9yq20q82gphp2nflc7jtzrcazrra7wwgzxqc8u7754cdlpfrmccae92qgzqvzq2ps8pqqqqqqpqqqqq9qqqvpeuqafqxu92d8lr6fvg0r5gv0heeeqgcrqlnm6jhphu9y00rrhy4grqszsvpcgpy9qqqqqqgqqqqq7qqzqj9n4evl6mr5aj9f58zp6fyjzup6ywn3x6sk8akg5v4tgn2q8g4fhx05wf6juaxu9760yp46454gpg5mtzgerlzezqcqvjnhjh8z3g2qqdhhwkj',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0.02,
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {
        'type': 'purpose_hash',
        'data':
            '3925b6f67e2c340036ed12093dd44e0368df1b6ea26c53dbe4811f58fd5db8c1'
      },
      {
        'type': 'fallback_address',
        'data': '1704b61f7dc1ea0dc99424464cc4064dc564d91e89'
      },
      {
        'type': 'routing',
        'data': [
          {
            'pubkey':
                '029e03a901b85534ff1e92c43c74431f7ce72046060fcf7a95c37e148f78c77255',
            'short_channel_id': '0102030405060708',
            'fee_base_msat': 1,
            'fee_proportional_millionths': 20,
            'cltv_expiry_delta': 3
          },
          {
            'pubkey':
                '039e03a901b85534ff1e92c43c74431f7ce72046060fcf7a95c37e148f78c77255',
            'short_channel_id': '030405060708090a',
            'fee_base_msat': 2,
            'fee_proportional_millionths': 30,
            'cltv_expiry_delta': 4
          }
        ]
      }
    ],
    'signature':
        '91675cb3fad8e9d915343883a49242e074474e26d42c7ed914655689a8074553733e8e4ea5ce9b85f69e40d755a55014536b12323f8b220600c94ef2b9c5142800'
  },
  {
    'request':
        'lnbc20m1pvjluezhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqspp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqfppj3a24vwu6r8ejrss3axul8rxldph2q7z9kmrgvr7xlaqm47apw3d48zm203kzcq357a4ls9al2ea73r8jcceyjtya6fu5wzzpe50zrge6ulk4nvjcpxlekvmxl6qcs9j3tz0469gq5g658y',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0.02,
    'tagged': [
      {
        'type': 'purpose_hash',
        'data':
            '3925b6f67e2c340036ed12093dd44e0368df1b6ea26c53dbe4811f58fd5db8c1'
      },
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {
        'type': 'fallback_address',
        'data': '188f55563b9a19f321c211e9b9f38cdf686ea07845'
      }
    ],
    'signature':
        'b6c6860fc6ff41bafba1745b538b6a7c6c2c0234f76bf817bf567be88cf2c632492c9dd279470841cd1e21a33ae7ed59b25809bf9b3366fe81881651589f5d1500'
  },
  {
    'request':
        'lnbc20m1pvjluezhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqspp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqfppqw508d6qejxtdg4y5r3zarvary0c5xw7kepvrhrm9s57hejg0p662ur5j5cr03890fa7k2pypgttmh4897d3raaq85a293e9jpuqwl0rnfuwzam7yr8e690nd2ypcq9hlkdwdvycqa0qza8',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0.02,
    'tagged': [
      {
        'type': 'purpose_hash',
        'data':
            '3925b6f67e2c340036ed12093dd44e0368df1b6ea26c53dbe4811f58fd5db8c1'
      },
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {
        'type': 'fallback_address',
        'data': '00751e76e8199196d454941c45d1b3a323f1433bd6'
      }
    ],
    'signature':
        'c8583b8f65853d7cc90f0eb4ae0e92a606f89caf4f7d65048142d7bbd4e5f3623ef407a75458e4b20f00efbc734f1c2eefc419f3a2be6d51038016ffb35cd61300'
  },
  {
    'request':
        'lnbc20m1pvjluezhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqspp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqfp4qrp33g0q5c5txsp9arysrx4k6zdkfs4nce4xj0gdcccefvpysxf3q28j0v3rwgy9pvjnd48ee2pl8xrpxysd5g44td63g6xcjcu003j3qe8878hluqlvl3km8rm92f5stamd3jw763n3hck0ct7p8wwj463cql26ava',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1496314658'),
    'amount': 0.02,
    'tagged': [
      {
        'type': 'purpose_hash',
        'data':
            '3925b6f67e2c340036ed12093dd44e0368df1b6ea26c53dbe4811f58fd5db8c1'
      },
      {
        'type': 'payment_hash',
        'data':
            '0001020304050607080900010203040506070809000102030405060708090102'
      },
      {
        'type': 'fallback_address',
        'data':
            '001863143c14c5166804bd19203356da136c985678cd4d27a1b8c6329604903262'
      }
    ],
    'signature':
        '51e4f6446e410a164a6da9f39507e730c26241b4456ab6ea28d1b12c71ef8ca20c9cfe3dffc07d9f8db671ecaa4d20beedb193bda8ce37c59f85f82773a55d4700'
  },
  {
    'request':
        'lnbc11p3l8hmnpp5fszjygxclu4v8lk9aqwentt8yku9fw23leqsagd824dtgxkhdk5sdqqcqzzgxqyz5vqrzjqwnvuc0u4txn35cafc7w94gxvq5p3cu9dd95f7hlrh0fvs46wpvhdut0l0wdgvxeu5qqqqryqqqqthqqpyrzjqw8c7yfutqqy3kz8662fxutjvef7q2ujsxtt45csu0k688lkzu3ldut0l0wdgvxeu5qqqqryqqqqthqqpysp5sfddfymd22vyr6fq00hxay5nu0qjjhfeu73kft95yvyq7zgksems9qypqsqgnlqghe7e60u00p0gseghk779fc837r74k9l5wwpyh9thdr847j55r9kgqae6yc829atajeaps998sr2vdrzyrjqywh7anvxm6ewzrgqasp0t5',
    'prefix': PayRequestPrefix.lnbc,
    'timestamp': Int64.parseInt('1676926835'),
    'amount': 1,
    'tagged': [
      {
        'type': 'payment_hash',
        'data':
            '4c052220d8ff2ac3fec5e81d99ad6725b854b951fe410ea1a7555ab41ad76da9'
      },
      {'type': 'description', 'data': ''},
      {'type': 'min_final_cltv_expiry', 'data': 72},
      {'type': 'expiry', 'data': 86400},
      {
        'type': 'routing',
        'data': [
          {
            'pubkey':
                '03a6ce61fcaacd38d31d4e3ce2d506602818e3856b4b44faff1dde9642ba705976',
            'short_channel_id': 'f16ffbdcd430d9e5',
            'fee_base_msat': 100,
            'fee_proportional_millionths': 1500,
            'cltv_expiry_delta': 9
          }
        ]
      },
      {
        'type': 'routing',
        'data': [
          {
            'pubkey':
                '038f8f113c580048d847d6949371726653e02b928196bad310e3eda39ff61723f6',
            'short_channel_id': 'f16ffbdcd430d9e5',
            'fee_base_msat': 100,
            'fee_proportional_millionths': 1500,
            'cltv_expiry_delta': 9
          }
        ]
      },
      {
        'type': 'payment_secret',
        'data':
            '825ad4936d529841e9207bee6e9293e3c1295d39e7a364acb423080f09168677',
      },
      {
        'type': 'feature_bits',
        'data': {
          'word_length': 4,
          'option_data_loss_protect': {
            'required': false,
            'supported': false,
          },
          'initial_routing_sync': {
            'required': false,
            'supported': false,
          },
          'option_upfront_shutdown_script': {
            'required': false,
            'supported': false,
          },
          'gossip_queries': {
            'required': false,
            'supported': false,
          },
          'var_onion_optin': {
            'required': false,
            'supported': true,
          },
          'gossip_queries_ex': {
            'required': false,
            'supported': false,
          },
          'option_static_remotekey': {
            'required': false,
            'supported': false,
          },
          'payment_secret': {
            'required': false,
            'supported': true,
          },
          'basic_mpp': {
            'required': false,
            'supported': true,
          },
          'option_support_large_channel': {
            'required': false,
            'supported': false,
          },
          'option_anchor_outputs': {
            'required': false,
            'supported': false,
          },
          'option_anchors_zero_fee_htlc_tx': {
            'required': false,
            'supported': true,
          },
          'option_shutdown_anysegwit': {
            'required': false,
            'supported': false,
          },
          'option_channel_type': {
            'required': false,
            'supported': false,
          },
          'option_payment_metadata': {
            'required': false,
            'supported': true,
          },
        }
      },
    ],
    'signature':
        '44fe045f3ece9fc7bc2f44328bdbde2a7078f87ead8bfa39c125cabbb467afa54a0cb6403b9d1307517abecb3d0c0a53c06a6346220e4023afeecd86deb2e10d00',
  }
];
