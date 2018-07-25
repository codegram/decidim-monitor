import { HttpClientModule } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { MatButtonModule } from '@angular/material/button';
import { MatCardModule } from '@angular/material/card';
import { MatChipsModule } from '@angular/material/chips';
import { MatIconModule } from '@angular/material/icon';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { MatToolbarModule } from '@angular/material/toolbar';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { EffectsModule } from '@ngrx/effects';
import { RouterStateSerializer, StoreRouterConnectingModule } from '@ngrx/router-store';
import { StoreModule } from '@ngrx/store';
import { StoreDevtoolsModule } from '@ngrx/store-devtools';
import { Apollo, ApolloModule } from 'apollo-angular';
import { NgrxCache, NgrxCacheModule } from 'apollo-angular-cache-ngrx';
import { HttpLink, HttpLinkModule } from 'apollo-angular-link-http';

import { environment } from '../environments/environment';
import { AppHome } from './app-home/app-home.component';
import { InstallationComponent } from './app-installation/app-installation.component';
import { AppLoading } from './app-loading/app-loading.component';
import { AppRoutingModule } from './app-routing.module';
import { AppSearch } from './app-search/app-search.component';
import { AppComponent } from './app.component';
import { InstallationList } from './installation-list/installation-list.component';
import { metaReducers, reducers } from './reducers';
import { CustomRouterStateSerializer } from './shared/utils';

@NgModule({
  declarations: [
    AppComponent,
    AppHome,
    InstallationComponent,
    InstallationList,
    AppLoading,
    AppSearch
  ],
  imports: [
    AppRoutingModule,
    BrowserModule,
    BrowserAnimationsModule,
    ApolloModule,
    HttpLinkModule,
    MatToolbarModule,
    MatCardModule,
    MatProgressSpinnerModule,
    MatChipsModule,
    MatButtonModule,
    MatIconModule,
    FormsModule,
    NgrxCacheModule,
    HttpClientModule,

    StoreModule.forRoot(reducers, { metaReducers }),

    StoreRouterConnectingModule.forRoot({
      stateKey: "router"
    }),

    StoreDevtoolsModule.instrument({
      logOnly: environment.production
    }),

    EffectsModule.forRoot([])
  ],
  providers: [
    { provide: RouterStateSerializer, useClass: CustomRouterStateSerializer }
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
  constructor(apollo: Apollo, httpLink: HttpLink, ngrxCache: NgrxCache) {
    apollo.create({
      // By default, this client will send queries to the
      // `/graphql` endpoint on the same host
      link: httpLink.create({
        uri: "/api"
      }),
      cache: ngrxCache.create({})
    });
  }
}
