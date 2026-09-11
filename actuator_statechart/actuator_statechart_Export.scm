{
  "graph": {
    "cells": [
      {
        "position": {
          "x": 0,
          "y": 0
        },
        "size": {
          "height": 10,
          "width": 10
        },
        "type": "Statechart",
        "id": "00ffb6d1-d225-4bc0-8b73-7df9987f57b7",
        "attrs": {
          "name": {
            "text": "actuator_statechart Export"
          },
          "specification": {
            "text": "@EventDriven\n@SuperSteps(no)\n\ninterface:\n\n    in event EV_LED_ON\n    in event EV_LED_OFF\n    in event EV_LED_BLINK\n    \n    out event LED_ON\n    out event LED_OFF\n    \n    \n    var tick: integer=0\n    var led_state: integer=0\n    \n    const DEL_ACT_BLINK: integer=10\n    const ON: integer=1\n    const OFF: integer=0"
          }
        },
        "z": 1
      },
      {
        "position": {
          "x": -262,
          "y": -63
        },
        "size": {
          "height": 60,
          "width": 60
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_LED_OFF",
            "fontSize": 11
          }
        },
        "id": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9",
        "z": 4,
        "embeds": [
          "65b3f876-01be-4e1c-8bf8-ec9220adafd9"
        ]
      },
      {
        "position": {
          "x": 85,
          "y": -82
        },
        "size": {
          "height": 60,
          "width": 96
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_LED_ON",
            "fontSize": 11
          }
        },
        "id": "f21f91e8-9a98-4d08-bdcf-a746fd1e1b43",
        "z": 15,
        "embeds": [
          "620bdb8d-4420-44fa-8085-31329c1bb146"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9"
        },
        "target": {
          "id": "f21f91e8-9a98-4d08-bdcf-a746fd1e1b43",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "13.333%",
              "dy": "50%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_LED_ON / raise LED_ON"
              }
            },
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "aeae2646-21cd-4c11-8d50-e50c79ac7b1a",
        "z": 16,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "f21f91e8-9a98-4d08-bdcf-a746fd1e1b43"
        },
        "target": {
          "id": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "91.667%",
              "dy": "68.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_LED_OFF/ raise LED_OFF"
              }
            },
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "12447a29-bad6-4b22-ab27-cd5b08642af1",
        "z": 17,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "position": {
          "x": -206,
          "y": -166
        },
        "size": {
          "height": 18,
          "width": 18
        },
        "type": "Entry",
        "entryKind": "Initial",
        "attrs": {},
        "id": "5c20bddb-46e8-4d1f-a3b4-9f96a787fccf",
        "z": 19,
        "embeds": [
          "9c5410ea-1ce2-4939-90fe-a5c8b0dd64c1"
        ]
      },
      {
        "type": "NodeLabel",
        "label": true,
        "size": {
          "width": 15,
          "height": 15
        },
        "position": {
          "x": -206,
          "y": -151
        },
        "attrs": {
          "label": {
            "refX": "50%",
            "textAnchor": "middle",
            "refY": "50%",
            "textVerticalAnchor": "middle"
          }
        },
        "id": "9c5410ea-1ce2-4939-90fe-a5c8b0dd64c1",
        "z": 20,
        "parent": "5c20bddb-46e8-4d1f-a3b4-9f96a787fccf"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "5c20bddb-46e8-4d1f-a3b4-9f96a787fccf"
        },
        "target": {
          "id": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "51.667%",
              "dy": "28.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {},
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "dd74d7d1-c4e5-484d-a674-8ee69c0c9cc7",
        "z": 21,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9"
        },
        "target": {
          "id": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "2.655%",
              "dy": "63.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_LED_OFF"
              }
            },
            "position": {
              "distance": 0.5927819219702597,
              "offset": -12.831268310546875,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "3"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "65b3f876-01be-4e1c-8bf8-ec9220adafd9",
        "z": 23,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -302,
            "y": -95
          },
          {
            "x": -337,
            "y": -95
          },
          {
            "x": -289,
            "y": -25
          }
        ],
        "parent": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "f21f91e8-9a98-4d08-bdcf-a746fd1e1b43"
        },
        "target": {
          "id": "f21f91e8-9a98-4d08-bdcf-a746fd1e1b43",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "79.167%",
              "dy": "53.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_LED_ON"
              }
            },
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "620bdb8d-4420-44fa-8085-31329c1bb146",
        "z": 24,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 109,
            "y": -127
          }
        ],
        "parent": "f21f91e8-9a98-4d08-bdcf-a746fd1e1b43"
      },
      {
        "position": {
          "x": -274,
          "y": 196
        },
        "size": {
          "height": 80,
          "width": 204
        },
        "type": "State",
        "attrs": {
          "name": {
            "text": "ST_LED_BLINK",
            "fontSize": 11
          }
        },
        "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead",
        "z": 32,
        "embeds": [
          "4318404a-ef68-493a-ab06-4057536ddbb7",
          "885b62be-1ad7-4ea2-bdbf-75735807aa16"
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "f21f91e8-9a98-4d08-bdcf-a746fd1e1b43"
        },
        "target": {
          "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "92.157%",
              "dy": "77.5%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_LED_BLINK/ tick=0; led_state=ON"
              }
            },
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "3"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "1eb70119-607e-495a-9fb3-6692d5e7dcb8",
        "z": 33,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 133,
            "y": 221
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9"
        },
        "target": {
          "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "58.333%",
              "dy": "25%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_LED_BLINK / raise LED_ON; tick=0; led_state=ON\n"
              }
            },
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "ddcfecd9-f229-44a4-9b28-7563ec9c9556",
        "z": 33,
        "router": {
          "name": "orthogonal"
        },
        "vertices": []
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead"
        },
        "target": {
          "id": "dee183dd-dd81-463b-881f-fa8b0a4cc8e9",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "18.584%",
              "dy": "70%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_LED_OFF/raise LED_OFF"
              }
            },
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "2"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "c5d69ee0-2380-498e-98e0-471b823e3cf6",
        "z": 33,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -440,
            "y": 178
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead"
        },
        "target": {
          "id": "f21f91e8-9a98-4d08-bdcf-a746fd1e1b43",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "25%",
              "dy": "73.333%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "EV_LED_ON/raise LED_ON"
              }
            },
            "position": {}
          },
          {
            "attrs": {
              "label": {
                "text": "1"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "46950d02-74bc-4be1-9fd8-63480fdd336b",
        "z": 33,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 6,
            "y": 203
          },
          {
            "x": 6,
            "y": 117
          }
        ]
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead"
        },
        "target": {
          "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "36.275%",
              "dy": "98.75%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "[tick >= DEL_ACT_BLINK && led_state == ON] / raise LED_OFF; led_state = OFF; tick = 0"
              }
            },
            "position": {
              "distance": 0.7712645372866179,
              "offset": -100.61532592773438,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "3"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "885b62be-1ad7-4ea2-bdbf-75735807aa16",
        "z": 33,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": -172,
            "y": 316
          },
          {
            "x": -294,
            "y": 316
          }
        ],
        "parent": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead"
      },
      {
        "type": "Transition",
        "attrs": {},
        "source": {
          "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead"
        },
        "target": {
          "id": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead",
          "anchor": {
            "name": "topLeft",
            "args": {
              "dx": "89.216%",
              "dy": "95%",
              "rotate": true
            }
          },
          "priority": true
        },
        "connector": {
          "name": "rounded"
        },
        "labels": [
          {
            "attrs": {
              "text": {
                "text": "[tick >= DEL_ACT_BLINK && led_state == OFF] / raise LED_ON; led_state = ON; tick = 0"
              }
            },
            "position": {
              "distance": 0.6986889584153241,
              "offset": 97.11531066894531,
              "angle": 0
            }
          },
          {
            "attrs": {
              "label": {
                "text": "4"
              }
            }
          },
          {
            "attrs": {}
          },
          {
            "attrs": {}
          }
        ],
        "id": "4318404a-ef68-493a-ab06-4057536ddbb7",
        "z": 34,
        "router": {
          "name": "orthogonal"
        },
        "vertices": [
          {
            "x": 3,
            "y": 317
          }
        ],
        "parent": "caa5b17c-42ac-4e5e-ba8e-c39618d1cead"
      }
    ]
  },
  "genModel": {
    "generator": {
      "type": "create::c",
      "features": {
        "Outlet": {
          "targetProject": "",
          "targetFolder": "",
          "libraryTargetFolder": "",
          "skipLibraryFiles": "",
          "apiTargetFolder": ""
        },
        "LicenseHeader": {
          "licenseText": ""
        },
        "FunctionInlining": {
          "inlineReactions": false,
          "inlineEntryActions": false,
          "inlineExitActions": false,
          "inlineEnterSequences": false,
          "inlineExitSequences": false,
          "inlineChoices": false,
          "inlineEnterRegion": false,
          "inlineExitRegion": false,
          "inlineEntries": false
        },
        "OutEventAPI": {
          "observables": false,
          "getters": false
        },
        "IdentifierSettings": {
          "moduleName": "Actuator",
          "statemachinePrefix": "actuator",
          "separator": "_",
          "headerFilenameExtension": "h",
          "sourceFilenameExtension": "c"
        },
        "Tracing": {
          "enterState": false,
          "exitState": false,
          "generic": false
        },
        "Includes": {
          "useRelativePaths": false,
          "generateAllSpecifiedIncludes": false
        },
        "GeneratorOptions": {
          "userAllocatedQueue": false,
          "metaSource": false
        },
        "GeneralFeatures": {
          "timerService": false,
          "timerServiceTimeType": ""
        },
        "Debug": {
          "dumpSexec": false
        }
      }
    }
  }
}