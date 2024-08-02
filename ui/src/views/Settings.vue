<!--
  Copyright (C) 2023 Nethesis S.r.l.
  SPDX-License-Identifier: GPL-3.0-or-later
-->
<template>
  <cv-grid fullWidth>
    <cv-row>
      <cv-column class="page-title">
        <h2>{{ $t("settings.title") }}</h2>
      </cv-column>
    </cv-row>
    <cv-row v-if="error.getConfiguration">
      <cv-column>
        <NsInlineNotification
          kind="error"
          :title="$t('action.get-configuration')"
          :description="error.getConfiguration"
          :showCloseButton="false"
        />
      </cv-column>
    </cv-row>
    <cv-row v-if="error.configureModule">
      <cv-column>
        <NsInlineNotification
          kind="error"
          :title="$t('action.configure-module')"
          :description="error.configureModule"
          :showCloseButton="false"
        />
      </cv-column>
    </cv-row>
    <cv-row
      v-if="
        loading.getConfiguration ||
        loading.getAvailableInterfacesBeforeConfiguration
      "
    >
      <cv-column>
        <cv-tile light>
          <cv-skeleton-text width="100px" heading />
          <cv-skeleton-text
            width="60%"
            class="title-description mg-bottom-xlg"
          />
          <cv-skeleton-text width="100px" class="mg-bottom-lg" />
          <cv-skeleton-text width="70%" heading class="mg-bottom-lg" />
          <cv-button-skeleton size="default" />
        </cv-tile>
      </cv-column>
    </cv-row>
    <cv-row v-else>
      <cv-column>
        <cv-row>
          <cv-column>
            <cv-tile light>
              <cv-form @submit.prevent="configureModule">
                <h4>{{ $t("settings.general_title") }}</h4>
                <div class="title-description mg-bottom-xlg">
                  {{ $t("settings.general_description") }}
                </div>
                <cv-combo-box
                  v-model="interfaceField"
                  :title="$t('settings.interface_label')"
                  :label="$t('settings.interface_placeholder')"
                  :invalid-message="error.interfaceField"
                  :auto-filter="true"
                  :auto-highlight="true"
                  :options="availableInterfaces"
                  :disabled="
                    loading.getConfiguration ||
                    loading.configureModule ||
                    loading.getAvailableInterfacesBeforeConfiguration
                  "
                  ref="interfaceField"
                >
                </cv-combo-box>
                <NsButton
                  kind="primary"
                  :icon="Save20"
                  :loading="loading.configureModule"
                  :disabled="
                    loading.getConfiguration || loading.configureModule
                  "
                  >{{ $t("settings.save") }}</NsButton
                >
              </cv-form>
            </cv-tile>
          </cv-column>
        </cv-row>
        <cv-row v-if="configuration.interface">
          <cv-column>
            <cv-tile light>
              <cv-form @submit.prevent="configureModule">
                <h4>{{ $t("settings.DHCP_title") }}</h4>
                <div class="title-description mg-bottom-xlg">
                  {{ $t("settings.DHCP_description") }}
                </div>
                <NsToggle
                  :label="$t('settings.DHCP_enable_label')"
                  v-model="dhcpEnableField"
                  value="dhcpEnableField"
                  formItem
                  ref="dhcpEnableField"
                >
                  <template slot="text-left">{{
                    $t("settings.disabled")
                  }}</template>
                  <template slot="text-right">{{
                    $t("settings.enabled")
                  }}</template>
                </NsToggle>
                <div v-if="dhcpEnableField">
                  <cv-text-input
                    :label="$t('settings.DHCP_start_label')"
                    v-model="dhcpStartField"
                    :disabled="
                      loading.getConfiguration || loading.configureModule
                    "
                    :invalid-message="error.dhcpStartField"
                    ref="dhcpStartField"
                  ></cv-text-input>
                  <cv-text-input
                    :label="$t('settings.DHCP_end_label')"
                    v-model="dhcpEndField"
                    :disabled="
                      loading.getConfiguration || loading.configureModule
                    "
                    :invalid-message="error.dhcpEndField"
                    ref="dhcpEndField"
                  ></cv-text-input>
                  <cv-text-input
                    :label="$t('settings.DHCP_lease_label')"
                    :helper-text="$t('settings.DHCP_lease_hint')"
                    v-model="dhcpLeaseField"
                    :disabled="
                      loading.getConfiguration || loading.configureModule
                    "
                    :invalid-message="error.dhcpLeaseField"
                    ref="dhcpLeaseField"
                  >
                  </cv-text-input>
                </div>
                <NsButton
                  kind="secondary"
                  :icon="Save20"
                  :loading="loading.configureModule"
                  :disabled="
                    loading.getConfiguration || loading.configureModule
                  "
                >
                  {{ $t("settings.save") }}
                </NsButton>
              </cv-form>
            </cv-tile>
          </cv-column>
        </cv-row>
        <cv-row v-if="configuration.interface">
          <cv-column>
            <cv-tile light>
              <cv-form @submit.prevent="configureModule">
                <h4>{{ $t("settings.DNS_title") }}</h4>
                <div class="title-description mg-bottom-xlg">
                  {{ $t("settings.DNS_description") }}
                </div>
                <cv-row
                  v-if="is_dns_bound && !dnsEnableField && !is_dns_enabled"
                >
                  <cv-column>
                    <NsInlineNotification
                      kind="info"
                      :title="$t('settings.dns_server_is_running')"
                      :description="
                        $t('settings.dns_server_is_running_description')
                      "
                      :showCloseButton="false"
                    />
                  </cv-column>
                </cv-row>
                <NsToggle
                  :label="$t('settings.DNS_enable_label')"
                  v-model="dnsEnableField"
                  value="dnsEnableField"
                  formItem
                  :disabled="
                    is_dns_bound && !dnsEnableField && !is_dns_enabled
                  "
                  ref="dnsEnableField"
                >
                  <template slot="text-left">{{
                    $t("settings.disabled")
                  }}</template>
                  <template slot="text-right">{{
                    $t("settings.enabled")
                  }}</template>
                </NsToggle>
                <div v-if="dnsEnableField">
                  <cv-text-input
                    :label="$t('settings.DNS_primary_label')"
                    v-model="dnsPrimaryField"
                    :disabled="
                      loading.getConfiguration || loading.configureModule
                    "
                    :invalid-message="error.dnsPrimaryField"
                    ref="dnsPrimaryField"
                  ></cv-text-input>
                  <cv-text-input
                    :label="$t('settings.DNS_secondary_label')"
                    v-model="dnsSecondaryField"
                    :disabled="
                      loading.getConfiguration || loading.configureModule
                    "
                    :invalid-message="error.dnsSecondaryField"
                    ref="dnsSecondaryField"
                  ></cv-text-input>
                </div>
                <NsButton
                  kind="secondary"
                  :icon="Save20"
                  :loading="loading.configureModule"
                  :disabled="
                    loading.getConfiguration ||
                    loading.configureModule ||
                    (is_dns_bound && !dnsEnableField && !is_dns_enabled)
                  "
                  >{{ $t("settings.save") }}</NsButton
                >
              </cv-form>
            </cv-tile>
          </cv-column>
        </cv-row>
      </cv-column>
    </cv-row>
  </cv-grid>
</template>

<script>
import to from "await-to-js";
import { mapState } from "vuex";
import {
  QueryParamService,
  UtilService,
  TaskService,
  IconService,
  PageTitleService,
} from "@nethserver/ns8-ui-lib";

export default {
  name: "Settings",
  mixins: [
    TaskService,
    IconService,
    UtilService,
    QueryParamService,
    PageTitleService,
  ],
  pageTitle() {
    return this.$t("settings.title") + " - " + this.appName;
  },
  data() {
    return {
      q: {
        page: "settings",
      },
      urlCheckInterval: null,
      configuration: {},
      availableInterfaces: [],
      interfaceField: "",
      dhcpEnableField: false,
      dhcpStartField: "",
      dhcpEndField: "",
      dhcpLeaseField: 12,
      is_dns_bound: false,
      is_dns_enabled: false,
      dnsEnableField: false,
      dnsPrimaryField: "",
      dnsSecondaryField: "",
      loading: {
        getConfiguration: false,
        configureModule: false,
        getAvailableInterfacesBeforeConfiguration: false,
      },
      error: {
        getConfiguration: "",
        configureModule: "",
        getAvailableInterfacesBeforeConfiguration: "",
        interfaceField: "",
        dhcpEnableField: "",
        dhcpStartField: "",
        dhcpEndField: "",
        dhcpLeaseField: "",
        dnsEnableField: "",
        dnsPrimaryField: "",
        dnsSecondaryField: "",
      },
    };
  },
  computed: {
    ...mapState(["instanceName", "core", "appName"]),
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      vm.watchQueryData(vm);
      vm.urlCheckInterval = vm.initUrlBindingForApp(vm, vm.q.page);
    });
  },
  beforeRouteLeave(to, from, next) {
    clearInterval(this.urlCheckInterval);
    next();
  },
  created() {
    this.getAvailableInterfacesBeforeConfiguration();
  },
  methods: {
    async getAvailableInterfacesBeforeConfiguration() {
      this.loading.getAvailableInterfacesBeforeConfiguration = true;
      this.error.getAvailableInterfacesBeforeConfiguration = "";
      const taskAction = "get-available-interfaces";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.getAvailableInterfacesAborted
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.getAvailableInterfacesCompleted
      );

      const res = await to(
        this.createModuleTaskForApp(this.instanceName, {
          action: taskAction,
          extra: {
            title: this.$t("action." + taskAction),
            isNotificationHidden: true,
            eventId,
          },
        })
      );
      const err = res[0];

      if (err) {
        console.error(`error creating task ${taskAction}`, err);
        this.error.getAvailableInterfacesBeforeConfiguration =
          this.getErrorMessage(err);
        this.loading.getAvailableInterfacesBeforeConfiguration = false;
        return;
      }
    },
    getAvailableInterfacesAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.getAvailableInterfacesBeforeConfiguration = this.$t(
        "error.generic_error"
      );
      this.loading.getAvailableInterfacesBeforeConfiguration = false;
    },
    getAvailableInterfacesCompleted(taskContext, taskResult) {
      this.loading.getAvailableInterfacesBeforeConfiguration = false;
      const interfaces = [];
      taskResult.output.data.forEach((iface) => {
        interfaces.push({
          name: iface,
          label: iface,
          value: iface,
        });
      });
      this.availableInterfaces = interfaces;
      this.getConfiguration();
    },
    async getConfiguration() {
      this.loading.getConfiguration = true;
      this.error.getConfiguration = "";
      const taskAction = "get-configuration";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.getConfigurationAborted
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.getConfigurationCompleted
      );

      const res = await to(
        this.createModuleTaskForApp(this.instanceName, {
          action: taskAction,
          extra: {
            title: this.$t("action." + taskAction),
            isNotificationHidden: true,
            eventId,
          },
        })
      );
      const err = res[0];

      if (err) {
        console.error(`error creating task ${taskAction}`, err);
        this.error.getConfiguration = this.getErrorMessage(err);
        this.loading.getConfiguration = false;
        return;
      }
    },
    getConfigurationAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.getConfiguration = this.$t("error.generic_error");
      this.loading.getConfiguration = false;
    },
    getConfigurationCompleted(taskContext, taskResult) {
      this.loading.getConfiguration = false;
      const config = taskResult.output;
      this.configuration = config;

      const dhcp_server = config["dhcp-server"];
      const dns_server = config["dns-server"];

      this.interfaceField = config["interface"];
      this.dhcpEnableField = dhcp_server["enabled"];
      this.dhcpStartField = dhcp_server["start"];
      this.dhcpEndField = dhcp_server["end"];
      this.dhcpLeaseField = dhcp_server["lease"].toString();
      this.dnsEnableField = dns_server["enabled"];
      this.dnsPrimaryField = dns_server["primary-server"];
      this.dnsSecondaryField = dns_server["secondary-server"];
      this.is_dns_bound = config["is_dns_bound"];
      this.is_dns_enabled = config["is_dns_enabled"];
    },
    validateConfigureModule() {
      this.clearErrors(this);
      let isValidationOk = true;

      if (!this.interfaceField) {
        this.error.interfaceField = this.$t("common.required");

        if (isValidationOk) {
          this.focusElement("interfaceField");
          isValidationOk = false;
        }
      }
      if (this.dhcpEnableField) {
        if (!this.dhcpStartField) {
          this.error.dhcpStartField = this.$t("common.required");

          if (isValidationOk) {
            this.focusElement("dhcpStartField");
            isValidationOk = false;
          }
        }
        if (!this.dhcpEndField) {
          this.error.dhcpEndField = this.$t("common.required");

          if (isValidationOk) {
            this.focusElement("dhcpEndField");
            isValidationOk = false;
          }
        }
        if (!this.dhcpLeaseField) {
          this.error.dhcpLeaseField = this.$t("common.required");

          if (isValidationOk) {
            this.focusElement("dhcpLeaseField");
            isValidationOk = false;
          }
        }
      }
      if (this.dnsEnableField && !this.dnsPrimaryField) {
        this.error.dnsPrimaryField = this.$t("common.required");

        if (isValidationOk) {
          this.focusElement("dnsPrimaryField");
          isValidationOk = false;
        }
      }

      return isValidationOk;
    },
    configureModuleValidationFailed(validationErrors) {
      this.loading.configureModule = false;

      for (const validationError of validationErrors) {
        if (validationError.field === "dhcp-server.start") {
          this.error.dhcpStartField = this.$t(
            "settings." + validationError.error
          );
        }
        if (validationError.field === "dhcp-server.end") {
          this.error.dhcpEndField = this.$t(
            "settings." + validationError.error
          );
        }
        if (validationError.field === "dhcp-server.lease") {
          this.error.dhcpLeaseField = this.$t(
            "settings." + validationError.error
          );
        }
        if (validationError.field === "dns-server.primary-server") {
          this.error.dnsPrimaryField = this.$t(
            "settings." + validationError.error
          );
        }
        if (validationError.field === "dns-server.secondary-server") {
          this.error.dnsSecondaryField = this.$t(
            "settings." + validationError.error
          );
        }
      }
    },
    async configureModule() {
      const isValidationOk = this.validateConfigureModule();
      if (!isValidationOk) {
        return;
      }

      this.loading.configureModule = true;
      const taskAction = "configure-module";
      const eventId = this.getUuid();

      // register to task error
      this.core.$root.$once(
        `${taskAction}-aborted-${eventId}`,
        this.configureModuleAborted
      );

      // register to task validation
      this.core.$root.$once(
        `${taskAction}-validation-failed-${eventId}`,
        this.configureModuleValidationFailed
      );

      // register to task completion
      this.core.$root.$once(
        `${taskAction}-completed-${eventId}`,
        this.configureModuleCompleted
      );

      const res = await to(
        this.createModuleTaskForApp(this.instanceName, {
          action: taskAction,
          data: {
            interface: this.interfaceField,
            "dhcp-server": {
              enabled: this.dhcpEnableField,
              start: this.dhcpStartField,
              end: this.dhcpEndField,
              lease: parseInt(this.dhcpLeaseField),
            },
            "dns-server": {
              enabled: this.dnsEnableField,
              "primary-server": this.dnsPrimaryField,
              "secondary-server": this.dnsSecondaryField,
            },
          },
          extra: {
            title: this.$t("settings.configure_instance", {
              instance: this.instanceName,
            }),
            description: this.$t("common.processing"),
            eventId,
          },
        })
      );
      const err = res[0];

      if (err) {
        console.error(`error creating task ${taskAction}`, err);
        this.error.configureModule = this.getErrorMessage(err);
        this.loading.configureModule = false;
        return;
      }
    },
    configureModuleAborted(taskResult, taskContext) {
      console.error(`${taskContext.action} aborted`, taskResult);
      this.error.configureModule = this.$t("error.generic_error");
      this.loading.configureModule = false;
    },
    configureModuleCompleted() {
      this.loading.configureModule = false;

      // reload configuration
      this.getConfiguration();
    },
  },
};
</script>

<style scoped lang="scss">
@import "../styles/carbon-utils";
</style>
