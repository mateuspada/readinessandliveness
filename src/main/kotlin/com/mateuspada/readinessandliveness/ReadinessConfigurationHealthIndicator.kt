package com.mateuspada.readinessandliveness

import org.springframework.boot.actuate.health.Health
import org.springframework.boot.actuate.health.HealthIndicator
import org.springframework.context.annotation.Configuration

@Configuration
class ReadinessConfigurationHealthIndicator : HealthIndicator {
    override fun health(): Health {
        val checkedResourcesStatus = check()

        return if (checkedResourcesStatus) {
            Health.up().build()
        } else {
            Health.down()
                .withDetail("Error Code", "Erro XPTO")
                .build()
        }
    }

    fun check(): Boolean = false
}