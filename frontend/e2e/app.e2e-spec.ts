import { DecidimMonitorPage } from './app.po';

describe('decidim-monitor App', () => {
  let page: DecidimMonitorPage;

  beforeEach(() => {
    page = new DecidimMonitorPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
