import { ApolloClient, createNetworkInterface } from 'apollo-client';
import { ApolloModule } from 'apollo-angular';
import { MaterialModule } from '@angular/material';

import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppComponent } from './app.component';
import { InstallationComponent } from './installation/installation.component';
import { VersionerService } from './versioner.service';

const client = new ApolloClient({
  networkInterface: createNetworkInterface({
    uri: '/api'
  }),
});

export function provideClient(): ApolloClient {
  return client;
}

@NgModule({
  declarations: [
    AppComponent,
    InstallationComponent
  ],
  imports: [
    BrowserModule,
    ApolloModule.forRoot(provideClient),
    MaterialModule,
    FormsModule,
    HttpModule
  ],
  providers: [VersionerService],
  bootstrap: [AppComponent]
})
export class AppModule { }
