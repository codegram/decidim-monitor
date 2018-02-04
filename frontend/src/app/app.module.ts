import { AppSearch } from "./app-search/app-search.component";
import { AppLoading } from "./app-loading/app-loading.component";
import { InstallationList } from "./installation-list/installation-list.component";
import { ApolloModule, Apollo } from "apollo-angular";

import { StoreModule } from "@ngrx/store";
import { EffectsModule } from "@ngrx/effects";
import {
  StoreRouterConnectingModule,
  RouterStateSerializer
} from "@ngrx/router-store";
import { StoreDevtoolsModule } from "@ngrx/store-devtools";

import { reducers, metaReducers } from "./reducers";

import { MatCardModule } from "@angular/material/card";
import { MatToolbarModule } from "@angular/material/toolbar";
import { MatProgressSpinnerModule } from "@angular/material/progress-spinner";
import { MatChipsModule } from "@angular/material/chips";
import { MatIconModule } from "@angular/material/icon";
import { MatButtonModule } from "@angular/material/button";

import { BrowserModule } from "@angular/platform-browser";
import { BrowserAnimationsModule } from "@angular/platform-browser/animations";
import { NgModule } from "@angular/core";
import { FormsModule } from "@angular/forms";
import { HttpModule } from "@angular/http";

import { InstallationComponent } from "./app-installation/app-installation.component";
import { AppComponent } from "./app.component";
import { AppHome } from "./app-home/app-home.component";
import { AppRoutingModule } from "./app-routing.module";
import { HttpClientModule } from "@angular/common/http";

import { HttpLinkModule, HttpLink } from "apollo-angular-link-http";
import { InMemoryCache } from "apollo-cache-inmemory";
import { NgrxCacheModule, NgrxCache } from "apollo-angular-cache-ngrx";

import { environment } from "../environments/environment";
import { CustomRouterStateSerializer } from "./shared/utils";

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
    HttpClientModule,
    MatToolbarModule,
    MatCardModule,
    MatProgressSpinnerModule,
    MatChipsModule,
    MatButtonModule,
    MatIconModule,
    FormsModule,
    HttpModule,
    NgrxCacheModule,

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
