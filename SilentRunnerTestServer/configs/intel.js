'use strict';

const intel = require('intel');

const intel_config = {
  format: "[%(date)s] %(name)s.%(levelname)s: %(message)s",
  level: intel.VERBOSE
}

intel.basicConfig(intel_config);

module.exports = intel_config;
