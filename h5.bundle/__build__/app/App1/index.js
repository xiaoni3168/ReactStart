webpackJsonp([5],{0:function(e,t,n){"use strict";function o(e){return e&&e.__esModule?e:{"default":e}}function r(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function u(e,t){if(!e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return!t||"object"!=typeof t&&"function"!=typeof t?e:t}function l(e,t){if("function"!=typeof t&&null!==t)throw new TypeError("Super expression must either be null or a function, not "+typeof t);e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,enumerable:!1,writable:!0,configurable:!0}}),t&&(Object.setPrototypeOf?Object.setPrototypeOf(e,t):e.__proto__=t)}var i=n(2),a=o(i);n(496);var c=n(51),f=n(102),s=o(f),p={childRoutes:[{path:"/",component:n(276),childRoutes:[n(277)]}]},d=function(e){function t(){r(this,t);var n=u(this,e.call(this));return n.state={},n}return l(t,e),t.prototype.render=function(){return a["default"].createElement(c.Router,{history:c.hashHistory,routes:p})},t}(a["default"].Component);s["default"].render(a["default"].createElement(d,null),document.getElementById("content"))},276:function(e,t,n){"use strict";function o(e){return e&&e.__esModule?e:{"default":e}}function r(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function u(e,t){if(!e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return!t||"object"!=typeof t&&"function"!=typeof t?e:t}function l(e,t){if("function"!=typeof t&&null!==t)throw new TypeError("Super expression must either be null or a function, not "+typeof t);e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,enumerable:!1,writable:!0,configurable:!0}}),t&&(Object.setPrototypeOf?Object.setPrototypeOf(e,t):e.__proto__=t)}var i=n(2),a=o(i),c=n(179),f=function(e){function t(){return r(this,t),u(this,e.apply(this,arguments))}return l(t,e),t.prototype.render=function(){return a["default"].createElement("div",null,a["default"].createElement("div",{style:{padding:20}},this.props.children),a["default"].createElement("div",null,"Hello App"),a["default"].createElement("div",null,"test"),a["default"].createElement(c.Component1,null),a["default"].createElement(c.Component2,null),a["default"].createElement("div",{className:"bk trans"}))},t}(i.Component);e.exports=f},277:function(e,t,n){"use strict";function o(e){return e&&e.__esModule?e:{"default":e}}function r(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function u(e,t){if(!e)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return!t||"object"!=typeof t&&"function"!=typeof t?e:t}function l(e,t){if("function"!=typeof t&&null!==t)throw new TypeError("Super expression must either be null or a function, not "+typeof t);e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,enumerable:!1,writable:!0,configurable:!0}}),t&&(Object.setPrototypeOf?Object.setPrototypeOf(e,t):e.__proto__=t)}var i=n(2),a=o(i),c=function(e){function t(){return r(this,t),u(this,e.apply(this,arguments))}return l(t,e),t.prototype.render=function(){var e=[{id:0,title:"essay due"}];return a["default"].createElement("div",null,a["default"].createElement("h2",null,"Home2"),a["default"].createElement("ul",null,e.map(function(e){return a["default"].createElement("li",{key:e.id},e.title)})),a["default"].createElement("div",null,"I'm a pic"))},t}(i.Component);e.exports={path:"home",getComponent:function(e,t){t(null,c)}}},496:208});