module.exports = {
  name: 'fant',
  build: {
    css: {
      preprocessor: 'sass',
    },
    site: {
      publicPath: '/fant/',
    },
  },
  site: {
    title: 'fant',
    logo: './logo.png',
    nav: [
      {
        title: '开发指南',
        items: [
          {
            path: 'home',
            title: '介绍',
          },
          {
            path: 'quickstart',
            title: '快速上手',
          },
        ],
      },
      {
        title: '基础组件',
        items: [
          {
            path: 'button',
            title: 'Button 按钮',
          },
        ],
      },
    ],
  },
};
