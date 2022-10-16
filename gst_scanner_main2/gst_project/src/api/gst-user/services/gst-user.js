'use strict';

/**
 * gst-user service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::gst-user.gst-user');
