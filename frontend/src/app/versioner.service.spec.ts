import { TestBed, inject } from '@angular/core/testing';

import { VersionerService } from './versioner.service';

describe('VersionerService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [VersionerService]
    });
  });

  it('should ...', inject([VersionerService], (service: VersionerService) => {
    expect(service).toBeTruthy();
  }));
});
