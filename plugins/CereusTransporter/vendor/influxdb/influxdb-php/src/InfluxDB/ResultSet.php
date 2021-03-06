<?php
/**
 * @author Stephen "TheCodeAssassin" Hoogendijk
 */

namespace InfluxDB;

use InfluxDB\Client\Exception as ClientException;

/**
 * Class ResultSet
 *
 * @package InfluxDB
 */
class ResultSet
{
    /**
     * @var string
     */
    protected $raw = '';

    /**
     * @var array|mixed
     */
    protected $parsedResults = array();

    /**
     * @param $raw
     *
     * @throws \InvalidArgumentException
     * @throws Exception
     */
    public function __construct($raw)
    {
        $this->raw = $raw;

        $this->parsedResults = json_decode($raw, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new \InvalidArgumentException("Invalid JSON");
        }

        // There was an error in the query thrown by influxdb
        if (isset($this->parsedResults['error'])) {
            throw new ClientException($this->parsedResults['error']);

            // Check if there are errors in the first serie
        } elseif (isset($this->parsedResults['results'][0]['error'])) {
            throw new ClientException($this->parsedResults['results'][0]['error']);
        }
    }

    /**
     * @param $metricName
     * @param array $tags
     *
     * @return array $points
     */
    public function getPoints($metricName = '', array $tags = array())
    {
        $points = array();
        $series = $this->getSeries();

        foreach ($series as $serie) {

            if ((empty($metricName) && empty($tags)
                || $serie['name'] == $metricName
                || (isset($serie['tags']) && array_intersect($tags, $serie['tags'])))
                && isset($serie['values'])
            ) {
                $points = array_merge($points, $this->getPointsFromSerie($serie));
            }
        }

        return $points;
    }

    /**
     * @see: https://influxdb.com/docs/v0.9/concepts/reading_and_writing_data.html
     *
     * results is an array of objects, one for each query,
     * each containing the keys for a series
     *
     * @throws Exception
     *
     * @return array $series
     */
    public function getSeries()
    {
        $pickSeries = function ($object) {

            if (isset($object['error'])) {
                throw new ClientException($object['error']);
            }

            return (isset($object['series']) ? $object['series'] : array());
        };

        // we use array_shift because of compatibility with php5.3
        // Foreach object, pick series key
        $map = array_map($pickSeries, $this->parsedResults['results']);
        return array_shift(
            $map
        );
    }

    /**
     * @param array $serie
     * @return array
     */
    private function getPointsFromSerie(array $serie)
    {
        $points = array();

        foreach ($serie['values'] as $point) {
            $points[] = array_combine(
                $serie['columns'],
                $point
            );
        }

        return $points;
    }

}