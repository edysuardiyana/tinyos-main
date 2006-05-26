/**
 * TestNetworkC exercises the basic networking layers, collection and
 * dissemination. The application samples DemoSensorC at a basic rate
 * and sends packets up a collection tree. The rate is configurable
 * through dissemination.
 *
 * See TEP118: Dissemination and TEP 119: Collection for details.
 * 
 * @author Philip Levis
 * @version $Revision: 1.1.2.3 $ $Date: 2006-05-26 00:25:03 $
 */

configuration TestNetworkAppC {}
implementation {
  components TestNetworkC, MainC, LedsC, ActiveMessageC;
  components new DisseminatorC(uint16_t, 0x1) as Object16C;
  components new CollectionSenderC(0);
  components TreeCollectionC as Collector;
  components new TimerMilliC();
  components new DemoSensorC();

  TestNetworkC.Boot -> MainC;
  TestNetworkC.RadioControl -> ActiveMessageC;
  TestNetworkC.RoutingControl -> Collector;
  TestNetworkC.Leds -> LedsC;
  TestNetworkC.Timer -> TimerMilliC;
  TestNetworkC.DisseminationPeriod -> Object16C;
  TestNetworkC.Send -> CollectionSenderC;
  TestNetworkC.ReadSensor -> DemoSensorC;
  TestNetworkC.RootControl -> Collector;
  TestNetworkC.Receive -> Collector.Receive[0];
}
